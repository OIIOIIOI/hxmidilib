package com.newgonzo.midi.events;

import flash.events.Event;

// TODO: Fill this out to reflect the current properties of the MIDIClock instance it came from
class ClockEvent extends Event {
	
	public static var CLOCK:String = "midiClock";
	public static var BEAT:String = "midiBeat";
	public static var START:String = "midiStart";
	public static var STOP:String = "midiStop";
	public static var POSITION:String = "midiPosition";
	
	public function new (type:String) {
		super(type, false, true);
	}
	
	override public function clone () :Event {
		return new ClockEvent(type);
	}
	
	override public function toString () :String {
		return formatToString("ClockEvent", "type");
	}
	
}
