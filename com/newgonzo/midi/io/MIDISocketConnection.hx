package com.newgonzo.midi.io;

import flash.errors.Error;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.Socket;
import flash.utils.ByteArray;

class MIDISocketConnection extends MIDIConnection {
	
	var midiSocket:Socket;
	
	public function new()
	{
		super();
	}
	
	override public function get connected():Bool
	{
		return midiSocket ? midiSocket.connected : super.connected;
	}
	
	override public function connect (...args) :Void {
		var host:String = String(args[0]);
		var port:UInt = uint(args[1]);
		
		midiSocket = new Socket();
		midiSocket.addEventListener(Event.CONNECT, socketConnected, false, 0, true);
		midiSocket.addEventListener(Event.CLOSE, socketClosed, false, 0, true);
		midiSocket.addEventListener(ProgressEvent.SOCKET_DATA, socketData, false, 0, true);
		midiSocket.addEventListener(IOErrorEvent.IO_ERROR, socketError, false, 0, true);
		midiSocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, socketError, false, 0, true);
		midiSocket.connect(host, port);
	}
	
	override public function close () :Void {
		releaseSocket();
		super.close();
	}
	
	function releaseSocket () :Void {
		if(midiSocket == null)	return;
		
		midiSocket.removeEventListener(Event.CONNECT, socketConnected);
		midiSocket.removeEventListener(Event.CLOSE, socketClosed);
		midiSocket.removeEventListener(ProgressEvent.SOCKET_DATA, socketData);
		midiSocket.removeEventListener(IOErrorEvent.IO_ERROR, socketError);
		midiSocket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, socketError);
		
		try {
			midiSocket.close();
		}
		catch (e:Error) { }
		
		midiSocket = null;
	}
	
	function socketConnected (e:Event) :Void {
		super.connect();
		dispatchEvent(e);
	}
	
	function socketClosed (e:Event) :Void {
		close();
		dispatchEvent(e);
	}
	
	function socketData (e:ProgressEvent) :Void {
		var data:ByteArray = new ByteArray();
		midiSocket.readBytes(data);
		receiveBytes(data);
	}
	
	function socketError (e:ErrorEvent) :Void {
		close();
		dispatchEvent(e);
	}
	
}
