package com.newgonzo.midi;

@:enum
abstract MIDINote(UInt) from UInt{
	
	inline var C 			=	0;
	inline var C_SHARP 		=	1;
	inline var D 			=	2;
	inline var D_SHARP 		=	3;
	inline var E 			=	4;
	inline var F 			=	5;
	inline var F_SHARP 		=	6;
	inline var G 			=	7;
	inline var G_SHARP 		=	8;
	inline var A 			=	9;
	inline var A_SHARP 		=	10;
	inline var B 			=	11;
	
	public function toUInt() : UInt {
		return cast this;
	}
	
	public static function toString( value:MIDINote ) : String {
		return
		switch(value){
			case C			:"C";
			case C_SHARP	:"C#";
			case D			:"D";
			case D_SHARP	:"D#";
			case E			:"E";
			case F			:"F";
			case F_SHARP	:"F#";
			case G			:"G";
			case G_SHARP	:"G#";
			case A			:"A";
			case A_SHARP	:"A#";
			case B			:"B";
			default			:"UNKNOWN";
		}
	}
	
}
