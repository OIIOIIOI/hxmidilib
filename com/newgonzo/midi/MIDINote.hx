package com.newgonzo.midi;

class MIDINote {
	
	public static var C:UInt =			0;
	public static var C_SHARP:UInt =	1;
	public static var D:UInt =			2;
	public static var D_SHARP:UInt =	3;
	public static var E:UInt =			4;
	public static var F:UInt =			5;
	public static var F_SHARP:UInt =	6;
	public static var G:UInt =			7;
	public static var G_SHARP:UInt =	8;
	public static var A:UInt =			9;
	public static var A_SHARP:UInt =	10;
	public static var B:UInt =			11;
	
	public static function toString (value:UInt) :String {
		if (value == C)				return "C";
		else if (value == C_SHARP)	return "C#";
		else if (value == D)		return "D";
		else if (value == D_SHARP)	return "D#";
		else if (value == E)		return "E";
		else if (value == F)		return "F";
		else if (value == F_SHARP)	return "F#";
		else if (value == G)		return "G";
		else if (value == G_SHARP)	return "G#";
		else if (value == A)		return "A";
		else if (value == A_SHARP)	return "A#";
		else if (value == B)		return "B";
		else						return "UNKNOWN";
	}
	
}
