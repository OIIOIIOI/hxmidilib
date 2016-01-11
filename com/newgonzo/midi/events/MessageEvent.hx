package com.newgonzo.midi.events;

import com.newgonzo.midi.messages.Message;
import flash.events.Event;

class MessageEvent extends Event {
	
	public static var MESSAGE:String = "midiMessage";
	
	var message(default, null):Message;
	
	public function new (type:String, message:Message = null) {
		super(type, false, false);
		this.message = message;
	}
	
	override public function clone () :Event {
		return new MessageEvent(type, message);
	}
	
	override public function toString () :String {
		#if flash
		return formatToString("MessageEvent", "message");
		#else 
		return "MessageEvent:" + super.toString();
		#end
	}
	
}
