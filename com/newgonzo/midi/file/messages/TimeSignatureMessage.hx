package com.newgonzo.midi.file.messages;

import com.newgonzo.midi.messages.Message;

class TimeSignatureMessage extends MetaEventMessage {
	
	public var numerator(default, null):UInt;
	public var denominator(default, null):UInt;
	
	public var clocksPerBeat(default, null):UInt;
	public var thirtySecondthsPerQuarter(default, null):UInt;
	
	public function new (numerator:UInt, denominator:UInt, clocksPerBeat:UInt, thirtySecondthsPerQuarter:UInt) {
		super(MetaEventMessageType.TIME_SIGNATURE);
		
		this.numerator = numerator;
		this.denominator = denominator;
		this.clocksPerBeat = clocksPerBeat;
		this.thirtySecondthsPerQuarter = thirtySecondthsPerQuarter;
	}
	
	override public function toString () :String {
		return "[TimeSignatureMessage(numerator=" + numerator + " denominator=" + denominator + " clocksPerBeat=" + clocksPerBeat + " thirtySecondthsPerQuarter=" + thirtySecondthsPerQuarter + ")]";
	}
}
