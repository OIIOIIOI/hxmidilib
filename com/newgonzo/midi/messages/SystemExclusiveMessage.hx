package com.newgonzo.midi.messages;

import flash.utils.ByteArray;

class SystemExclusiveMessage extends Message {
	
	var type(default, null):UInt;
	var data(default, null):ByteArray;
	
	public function new (type:UInt, data:ByteArray) {
		super(MessageStatus.SYSTEM);
		
		this.type = type;
		this.data = data;
	}
	
	override public function toString () :String {
		return "[SystemExclusiveMessage(type=" + type + " data=" + data + ")]";
	}
	
}
