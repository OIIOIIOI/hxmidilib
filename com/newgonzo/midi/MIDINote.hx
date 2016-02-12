package com.newgonzo.midi;

@:enum
abstract MIDINote(UInt) {
	
	var C 			=	0;
	var C_SHARP 	=	1;
	var D 			=	2;
	var D_SHARP 	=	3;
	var E 			=	4;
	var F 			=	5;
	var F_SHARP 	=	6;
	var G 			=	7;
	var G_SHARP 	=	8;
	var A 			=	9;
	var A_SHARP 	=	10;
	var B 			=	11;
	
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
