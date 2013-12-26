package com.newgonzo.midi.filters;

import com.newgonzo.midi.messages.Message;
import com.newgonzo.midi.messages.VoiceMessage;

class VoiceFilter extends AbstractFilter implements IMessageFilter
{
	public function new(filter:IMessageFilter = null)
	{
		super(filter);
	}
	
	override public function accepts(message:Message):Bool
	{
		var voiceMsg:VoiceMessage = cast(message);
		
		return voiceMsg && super.accepts(voiceMsg);
	}
}
