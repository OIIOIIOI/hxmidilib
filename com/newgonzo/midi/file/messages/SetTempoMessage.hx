package com.newgonzo.midi.file.messages;

class SetTempoMessage extends MetaEventMessage {
	
	var microsecondsPerQuarter(default, null):UInt;
	var tempo(default, null):UInt;
	
	public function new (microsecondsPerQuarter:UInt) {
		super(MetaEventMessageType.SET_TEMPO);
		
		this.microsecondsPerQuarter = microsecondsPerQuarter;
		this.tempo = Std.int(microsecondsPerQuarter / 24000);
	}
	
	override public function toString () :String {
		return "[SetTempoMessage(microsPerQuarter=" + microsecondsPerQuarter + " tempo=" + tempo + ")]";
	}
}
