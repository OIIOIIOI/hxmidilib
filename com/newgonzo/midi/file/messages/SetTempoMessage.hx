package com.newgonzo.midi.file.messages;

class SetTempoMessage extends MetaEventMessage {
	
	public var microsecondsPerQuarter(default, null):UInt;
	public var tempo(default, null):UInt;
	
	public function new (microsecondsPerQuarter:UInt) {
		super(MetaEventMessageType.SET_TEMPO);
		
		this.microsecondsPerQuarter = microsecondsPerQuarter;
		this.tempo = Std.int(microsecondsPerQuarter / 24000);
	}
	
	override public function toString () :String {
		return "[SetTempoMessage(microsPerQuarter=" + microsecondsPerQuarter + " tempo=" + tempo + ")]";
	}
}
