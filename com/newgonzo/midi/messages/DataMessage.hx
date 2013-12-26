package com.newgonzo.midi.messages;

class DataMessage extends Message {
	
	public var data1(default, null):Int;
	public var data2(default, null):Int;
	public var combinedData(get, never):Int;
	
	public function new (status:Int, data1:Int = 0, data2:Int = 0) {
		super(status);
		
		this.data1 = data1;
		this.data2 = data2;
	}
	
	function get_combinedData () :Int {
		var c:Int = data2;
		c <<= 7;
		c |= data1;
		return c;
	}
	
}
