package com.newgonzo.midi.filters;

import com.newgonzo.midi.messages.*;

class AbstractFilter
{
	var innerFilter:IMessageFilter;
	
	public function new(filter:IMessageFilter = null)
	{
		innerFilter = filter;
	}
	
	public function accepts(message:Message):Bool
	{
		if(!innerFilter || innerFilter.accepts(message))
		{
			return true;
		}
		
		return false;
	}
}
