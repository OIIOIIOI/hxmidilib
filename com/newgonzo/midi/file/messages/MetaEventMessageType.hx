package com.newgonzo.midi.file.messages;

class MetaEventMessageType {
	
	public static inline var SEQUENCE_NUM:Int =			0x00;
	               
	public static inline var TEXT:Int =					0x01;
	public static inline var COPYRIGHT:Int =			0x02;
	public static inline var TRACK_NAME:Int =			0x03;
	public static inline var INSTRUMENT_NAME:Int =		0x04;
	public static inline var LYRIC:Int =				0x05;
	public static inline var MARKER:Int =				0x06;
	public static inline var CUE_POINT:Int =			0x07;
	public static inline var PROGRAM_NAME:Int =			0x08;
	public static inline var DEVICE_NAME:Int =			0x09;
	               
	public static inline var CHANNEL_PREFIX:Int =		0x20;
	public static inline var MIDI_PORT:Int =			0x21;
	public static inline var END_OF_TRACK:Int =			0x2F;
	public static inline var SET_TEMPO:Int =			0x51;
	public static inline var SMPTE_OFFSET:Int =			0x54;
	public static inline var TIME_SIGNATURE:Int =		0x58;
	public static inline var KEY_SIGNATURE:Int =		0x59;
	public static inline var SEQUENCER_SPECIFIC:Int =	0x7F;
	
	public static function toString (value:Int) :String {
		if (value == SEQUENCE_NUM)				return "SEQUENCE_NUM";
		else if (value == TEXT)					return "TEXT";
		else if (value == COPYRIGHT)			return "COPYRIGHT";
		else if (value == TRACK_NAME)			return "TRACK_NAME";
		else if (value == INSTRUMENT_NAME)		return "INSTRUMENT_NAME";
		else if (value == LYRIC)				return "LYRIC";
		else if (value == MARKER)				return "MARKER";
		else if (value == CUE_POINT)			return "CUE_POINT";
		else if (value == PROGRAM_NAME)			return "PROGRAM_NAME";
		else if (value == DEVICE_NAME)			return "DEVICE_NAME";
		else if (value == CHANNEL_PREFIX)		return "CHANNEL_PREFIX";
		else if (value == MIDI_PORT)			return "MIDI_PORT";
		else if (value == END_OF_TRACK)			return "END_OF_TRACK";
		else if (value == SET_TEMPO)			return "SET_TEMPO";
		else if (value == SMPTE_OFFSET)			return "SMPTE_OFFSET";
		else if (value == TIME_SIGNATURE)		return "TIME_SIGNATURE";
		else if (value == KEY_SIGNATURE)		return "KEY_SIGNATURE";
		else if (value == SEQUENCER_SPECIFIC)	return "SEQUENCER_SPECIFIC";
		else									return "UNKNOWN";
	}
	
}
