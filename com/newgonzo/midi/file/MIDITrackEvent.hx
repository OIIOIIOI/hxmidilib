package com.newgonzo.midi.file;

import com.newgonzo.midi.messages.Message;

class MIDITrackEvent {
	
	public var time(default, null):UInt;
	public var message(default, null):Message;
	
	public function new (time:UInt, message:Message) {
		this.time = time;
		this.message = message;
	}
	
	public function toString () :String {
		return "[MIDITrackEvent(time=" + time + " message=" + message + ")]";
	}
}
