package com.newgonzo.midi.file.messages;

class SetTempoMessage extends MetaEventMessage {
	
	public var microsecondsPerQuarter(default, null):UInt;
	public var tempo(default, null):UInt;
	
	public var bpm:Float;
	public var bps:Float;
	
	public function new (microsecondsPerQuarter:UInt) {
		super(MetaEventMessageType.SET_TEMPO);
		
		this.microsecondsPerQuarter = microsecondsPerQuarter;
		this.tempo = Std.int(microsecondsPerQuarter / 24000);
		
		//this gives strange fractionnal dusts but haven't found a better calculus...
		//for a good result, we should round bpm then redivide by 60 for bps
		bpm = 60000000.0 / microsecondsPerQuarter;
		bps = (60000000.0/60.0) / microsecondsPerQuarter;
	}
	
	override public function toString () :String {
		return "[SetTempoMessage(microsPerQuarter=" + microsecondsPerQuarter + " tempo=" + tempo + ")]";
	}
}
