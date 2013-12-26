package com.newgonzo.midi.filters;

import com.newgonzo.midi.messages.Message;
import com.newgonzo.midi.messages.SystemMessage;

class SystemFilter extends AbstractFilter implements IMessageFilter
{
	var allowTypes:Array;
	
	public function new(allowTypes:Array = null, filter:IMessageFilter = null)
	{
		super(filter);
		this.allowTypes = allowTypes;
	}
	
	public function get types():Array
	{
		return allowTypes;
	}
	
	public function set types(value:Array):Void
	{
		allowTypes = value;
	}
	
	override public function accepts(message:Message):Bool
	{
		var sysMsg:SystemMessage = cast(message);
		
		return sysMsg && (!allowTypes || allowTypes.indexOf(sysMsg.type) != -1) && super.accepts(sysMsg);
	}
}
