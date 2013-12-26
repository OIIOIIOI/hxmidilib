package com.newgonzo.midi.file;

class MIDIFile {
	
	public var format(default, null):UInt;
	public var division(default, null):UInt;
	public var tracks(default, null):Array<MIDITrack>;
	public var numTracks(get, never):UInt;
	
	public function new (format:UInt, division:UInt, tracks:Array<MIDITrack> = null) {
		this.format = format;
		this.division = division;
		this.tracks = (tracks != null) ? tracks : new Array<MIDITrack>();
	}
	
	function get_numTracks () :UInt {
		return tracks.length;
	}
	
	public function toString () :String {
		return "[MIDIFile(format=" + format + " division=" + division + " numTracks=" + numTracks + " tracks=\n\t" + tracks.join("\n\t") + ")]";
	}
	
}
