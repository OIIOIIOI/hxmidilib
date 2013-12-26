package com.newgonzo.midi.messages;

import com.newgonzo.midi.MIDINote;

class VoiceMessage extends ChannelMessage {
	
	public var octave(get, never):Int;
	public var pitch(get, never):UInt;
	public var note(get, never):UInt;
	public var velocity(get, never):UInt;
	
	public function new (status:Int, channel:Int, data1:Int = 0, data2:Int = 0) {
		super(status, channel, data1, data2);
	}
	
	function get_octave () :Int {
		return Math.floor(data1 / 12) - 1;
	}
	
	function get_pitch () :UInt {
		return cast(data1, UInt);
	}
	
	function get_note () :UInt {
		return pitch % 12;
	}
	
	function get_velocity () :UInt {
		return cast(data2, UInt);
	}
	
	override public function toString () :String {
		return "[VoiceMessage(status=" + MessageStatus.toString(status) + " channel=" + channel + " note=" + MIDINote.toString(note) + " octave=" + octave + " velocity=" + velocity + ")]";
	}
	
}
