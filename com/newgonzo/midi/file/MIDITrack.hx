package com.newgonzo.midi.file;

class MIDITrack {
	
	public var events(default, null):Array<MIDITrackEvent>;
	
	public function new (events:Array<MIDITrackEvent>) {
		this.events = events;
	}
	
	public function toString () :String {
		return "[MIDITrack(events=\n\t" + events.join("\n\t") + ")]";
	}
	
}
