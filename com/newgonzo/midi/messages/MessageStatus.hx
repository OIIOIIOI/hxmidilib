package com.newgonzo.midi.messages;

class MessageStatus {
	
	public static inline var NOTE_OFF			: Int =	0x80;
	public static inline var NOTE_ON			: Int =	0x90;
	public static inline var KEY_PRESSURE		: Int =	0xA0;
	public static inline var CONTROL_CHANGE		: Int =	0xB0;
	public static inline var PROGRAM_CHANGE		: Int =	0xC0;
	public static inline var CHANNEL_PRESSURE	: Int =	0xD0;
	public static inline var PITCH_BEND			: Int =	0xE0;
	public static inline var SYSTEM				: Int =	0xF0;
	public static inline var INVALID			: Int =	0x00;
	
	static var STRING_TABLE:Map<Int, String>;
	
	static function init () {
		STRING_TABLE = new Map<Int, String>();
		STRING_TABLE.set(NOTE_OFF,			"NOTE_OFF");
		STRING_TABLE.set(NOTE_ON,			"NOTE_ON");
		STRING_TABLE.set(KEY_PRESSURE,		"KEY_PRESSURE");
		STRING_TABLE.set(CONTROL_CHANGE,	"CONTROL_CHANGE");
		STRING_TABLE.set(PROGRAM_CHANGE,	"PROGRAM_CHANGE");
		STRING_TABLE.set(CHANNEL_PRESSURE,	"CHANNEL_PRESSURE");
		STRING_TABLE.set(PITCH_BEND,		"PITCH_BEND");
		STRING_TABLE.set(SYSTEM,			"SYSTEM");
		STRING_TABLE.set(INVALID,			"INVALID");
	}
	
	public static function isStatus (value:Int) :Bool {
		if (STRING_TABLE == null)	init();
		return value != INVALID && STRING_TABLE.exists(value);
	}
	
	public static function toString (value:Int) :String {
		if (STRING_TABLE == null)	init();
		return STRING_TABLE.exists(value) ? STRING_TABLE.get(value) : STRING_TABLE.get(INVALID);
	}
}
