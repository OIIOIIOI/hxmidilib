package com.newgonzo.midi.filters;

import com.newgonzo.midi.messages.Message;

class StatusFilter extends AbstractFilter implements IMessageFilter
{
	var allowStatus:Array;
	
	public function new(allowStatus:Array, filter:IMessageFilter = null)
	{
		super(filter);
		this.allowStatus = allowStatus;
	}
	
	public function get status():Array
	{
		return allowStatus;
	}
	
	public function set status(value:Array):Void
	{
		allowStatus = value;
	}
	
	override public function accepts(message:Message):Bool
	{
		return allowStatus.indexOf(message.status) != -1 && super.accepts(message);
	}
}
