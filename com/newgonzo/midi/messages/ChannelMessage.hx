package com.newgonzo.midi.messages;

class ChannelMessage extends DataMessage {
	
	public var channel(default, null):Int;
	
	public function new (status:Int, channel:Int, data1:Int = 0, data2:Int = 0) {
		super(status, data1, data2);
		
		this.channel = channel;
	}
	
	override public function toString():String
	{
		return "[ChannelMessage(status=" + MessageStatus.toString(status) + " channel=" + channel + " data1=" + StringTools.hex(data1) + " data2=" + StringTools.hex(data2) + ")]";
	}
}
