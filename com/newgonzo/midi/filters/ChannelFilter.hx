package com.newgonzo.midi.filters;

import com.newgonzo.midi.messages.*;

class ChannelFilter extends AbstractFilter implements IMessageFilter
{
	var acceptedChannels:Array;
	
	public function new(channels:Array = null, filter:IMessageFilter = null)
	{
		super(filter);
		acceptedChannels = channels;
	}
	
	public function get channels():Array
	{
		return acceptedChannels;
	}
	
	public function set channels(value:Array):Void
	{
		acceptedChannels = value;
	}
	
	override public function accepts(message:Message):Bool
	{
		var channelMsg:ChannelMessage = cast(message);
		
		return channelMsg && (!acceptedChannels || acceptedChannels.indexOf(channelMsg.channel) != -1) && super.accepts(channelMsg);
	}
}
