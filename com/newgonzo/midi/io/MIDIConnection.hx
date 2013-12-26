package com.newgonzo.midi.io;

import com.newgonzo.midi.MIDIDecoder;
import com.newgonzo.midi.events.MessageEvent;
import com.newgonzo.midi.messages.Message;
import flash.events.EventDispatcher;
import flash.utils.ByteArray;

class MIDIConnection extends EventDispatcher implements IMIDIConnection {
	
	var decoder:MIDIDecoder;
	var connected(default, null):Bool
	
	public function new () {
		connected = false;
	}
	
	public function connect (...args) :Void {
		decoder = new MIDIDecoder();
		isConnected = true;
	}
	
	public function receiveBytes (data:ByteArray) :Void {
		receiveMessages(decoder.decodeMessages(data));
	}
	
	public function sendBytes (data:ByteArray) :Void {
		//sendMessages(encoder.encodeBytes(data));
	}
	
	public function close () :Void {
		decoder = null;
		isConnected = false;
	}
	
	public function receiveMessages (messages:Array) :Void {
		for (m in messages) {
			dispatchEvent(new MessageEvent(MessageEvent.MESSAGE, m));
		}
	}
}
