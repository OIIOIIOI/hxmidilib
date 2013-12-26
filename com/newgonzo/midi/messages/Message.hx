package com.newgonzo.midi.messages;

class Message {
	
	var status(default, null):UInt;
	
	public function new (status:UInt) {
		this.status = status;
	}
	
	public function toString () :String {
		return "[Message(status=" + MessageStatus.toString(status) + ")]";
	}
}
