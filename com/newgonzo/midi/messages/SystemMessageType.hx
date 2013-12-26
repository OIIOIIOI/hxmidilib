package com.newgonzo.midi.messages;

class SystemMessageType {
	
	public static var SYS_EX_START:Int = 0x0;
	public static var MIDI_TIME_CODE:Int = 0x1;
	public static var SONG_POSITION:Int = 0x2;
	public static var SONG_SELECT:Int = 0x3;
	public static var TUNE_REQUEST:Int = 0x6;
	public static var SYS_EX_END:Int = 0x7;
	public static var TIMING_CLOCK:Int = 0x8;
	public static var START:Int = 0xA;
	public static var CONTINUE:Int = 0xB;
	public static var STOP:Int = 0xC;
	public static var ACTIVE_SENSING:Int = 0xE;
	public static var SYSTEM_RESET:Int = 0xF;
	
	public static function toString (value:Int) :String {
		if (value == SYS_EX_START)			return "SYS_EX_START";
		else if (value == MIDI_TIME_CODE)	return "MIDI_TIME_CODE";
		else if (value == SONG_POSITION)	return "SONG_POSITION";
		else if (value == SONG_SELECT)		return "SONG_SELECT";
		else if (value == TUNE_REQUEST)		return "TUNE_REQUEST";
		else if (value == SYS_EX_END)		return "SYS_EX_END";
		else if (value == TIMING_CLOCK)		return "TIMING_CLOCK";
		else if (value == START)			return "START";
		else if (value == CONTINUE)			return "CONTINUE";
		else if (value == STOP)				return "STOP";
		else if (value == ACTIVE_SENSING)	return "ACTIVE_SENSING";
		else if (value == SYSTEM_RESET)		return "SYSTEM_RESET";
		else								return "UNKNOWN";
	}
	
}
