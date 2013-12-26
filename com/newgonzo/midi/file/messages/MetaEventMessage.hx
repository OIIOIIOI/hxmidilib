package com.newgonzo.midi.file.messages;

import com.newgonzo.midi.messages.Message;
import com.newgonzo.midi.messages.MessageStatus;
import com.newgonzo.midi.messages.SystemMessageType;

class MetaEventMessage extends Message {
	
	var type(default, null):UInt;
	
	public function new (type:UInt) {
		super(SystemMessageType.SYSTEM_RESET);
		
		this.type = type;
	}
	
	override public function toString () :String {
		return "[MetaEventMessage(status=" + StringTools.hex(status) + " type=" + MetaEventMessageType.toString(type) + ")]";
	}
}
