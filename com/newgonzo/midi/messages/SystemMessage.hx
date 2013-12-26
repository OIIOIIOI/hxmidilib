package com.newgonzo.midi.messages;

class SystemMessage extends DataMessage {
	
	var type(default, null):Int;
	
	public function new (type:Int, data1:Int = 0, data2:Int = 0) {
		super(MessageStatus.SYSTEM, data1, data2);
		
		this.type = type;
	}
	
	override public function toString () :String {
		return "[SystemMessage(status=" + MessageStatus.toString(status) + " type=" + SystemMessageType.toString(type) + " data1=" + data1 + " data2=" + data2 + ")]";
	}
	
}
