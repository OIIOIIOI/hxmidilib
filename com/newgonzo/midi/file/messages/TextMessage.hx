package com.newgonzo.midi.file.messages;

class TextMessage extends MetaEventMessage {
	
	var text(default, null):String;
	
	public function new (type:Int, text:String) {
		super(type);
		
		this.text = text;
	}
	
	override public function toString () :String {
		return "[TextMessage(type=" + type + " text=" + text + ")]";
	}
	
}
