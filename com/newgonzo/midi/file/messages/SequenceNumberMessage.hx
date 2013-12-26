package com.newgonzo.midi.file.messages;

class SequenceNumberMessage extends MetaEventMessage
{
	var sequenceValue1:UInt;
	var sequenceValue2:UInt;
	
	public function new(value1:UInt, value2:UInt)
	{
		super(MetaEventMessageType.SEQUENCE_NUM);
	
		sequenceValue1 = value1;
		sequenceValue2 = value2;
	}
	
	override public function toString():String
	{
		return "[SequenceNumberMessage(value1=" + sequenceValue1 + " value2=" + sequenceValue2 + ")]";
	}
}
