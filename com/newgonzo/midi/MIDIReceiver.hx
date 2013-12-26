package com.newgonzo.midi;

import com.newgonzo.midi.events.MessageEvent;
import com.newgonzo.midi.filters.IMessageFilter;
import com.newgonzo.midi.io.IMIDIConnection;
import com.newgonzo.midi.messages.Message;
import flash.events.EventDispatcher;

/**
 * A MIDIReceiver is a filtered view of a MIDI connection.
 */
class MIDIReceiver extends EventDispatcher
{
	var midiConnection:IMIDIConnection;
	var messageFilter:IMessageFilter;
	
	public function new(connection:IMIDIConnection, filter:IMessageFilter = null)
	{
		midiConnection = connection;
		messageFilter = filter;
		
		midiConnection.addEventListener(MessageEvent.MESSAGE, messageReceived, false, 0, true);
	}
	
	public function get connection():IMIDIConnection
	{
		return midiConnection;
	}
	
	public function get filter():IMessageFilter
	{
		return messageFilter;
	}
	
	function handleMessage(message:Message):Void
	{
		// override
	}
	
	function messageReceived(e:MessageEvent):Void
	{
		var message:Message = e.message;
		
		if(!messageFilter || messageFilter.accepts(message))
		{
			handleMessage(message);
			dispatchEvent(e);
		}
	}
}
