package com.newgonzo.midi.errors;

import flash.errors.Error;

class InvalidFormatError extends Error {
	
	public function new (message:String = "", id:Int = 0) {
		super(message, id);
	}
	
}
