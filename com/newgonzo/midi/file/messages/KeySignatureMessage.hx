package com.newgonzo.midi.file.messages;

import com.newgonzo.midi.messages.Message;

class KeySignatureMessage extends MetaEventMessage {
	
	var numAccidentals:Int;
	var minor(default, null):Bool;
	var key(default, null):UInt;
	public var sharps(get, never):UInt;
	public var flats(get, never):UInt;
	
	public function new (accidentals:Int, minor:Bool) {
		super(MetaEventMessageType.KEY_SIGNATURE);
		
		numAccidentals = accidentals;
		this.minor = minor;
		key = 0;
	}
	
	function get_sharps () :UInt {
		return numAccidentals > 0 ? numAccidentals : 0;
	}
	
	function get_flats () :UInt {
		return numAccidentals < 0 ? -numAccidentals : 0;
	}
	
	override public function toString () :String {
		return "[KeySignatureMessage(key=" + key + " sharps=" + sharps + " flats=" + flats + " minor=" + minor + ")]";
	}
}
