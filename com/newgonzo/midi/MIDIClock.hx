package com.newgonzo.midi;

import com.newgonzo.midi.events.ClockEvent;
import com.newgonzo.midi.filters.SystemFilter;
import com.newgonzo.midi.io.IMIDIConnection;
import com.newgonzo.midi.messages.Message;
import com.newgonzo.midi.messages.SystemMessage;
import com.newgonzo.midi.messages.SystemMessageType;
import flash.errors.Error;
import flash.utils.getTimer;

class MIDIClock extends MIDIReceiver
{
	// number of tics each
	public static var QUARTERS:Int = 24;
	public static var EIGHTHS:Int = 12;
	public static var SIXTEENTHS:Int = 6;
	public static var THIRTYSECONDTHS:Int = 3;
	
	public static var CLOCKS_PER_BEAT:Int = 6;
	public static var CLOCKS_PER_QUARTER:Int = 24;
	
	public static var TEMPOS_FOR_AVERAGE:Int = 15;
	
	var timingDivision:Int = QUARTERS;
	var count:Int = 0;
	
	var calculatedTempos:Array = new Array();
	var clockTempo:Float = 0;
	var averageTempo:Float = 0;
	
	var previousQuarterTime:Float = 0;
	var quarterTime:Float = 0;
	
	var currentBeat:Int = 0;
	var isStopped:Bool = true;
	
	public function new(connection:IMIDIConnection, division:Int = QUARTERS)
	{
		super(connection, new SystemFilter([SystemMessageType.TIMING_CLOCK, SystemMessageType.CONTINUE, SystemMessageType.SONG_POSITION, SystemMessageType.START, SystemMessageType.STOP]));
	
		timingDivision = division;
	}
	
	public function set division(value:Int):Void
	{
		timingDivision = value;
	}
	public function get division():Int
	{
		return timingDivision;
	}
	
	public function get tempo():Float
	{
		return averageTempo;
	}
	
	public function get beat():Int
	{
		return isStopped ? 1 : 1 + (currentBeat / (timingDivision / CLOCKS_PER_BEAT));
	}
	
	public function get position():Float
	{
		return isStopped ? 1 : beat + (count / CLOCKS_PER_QUARTER);
	}
	
	public function get stopped():Bool
	{
		return isStopped;
	}
	
	function calculateTempo():Void
	{
		var quarterDuration:Float = quarterTime - previousQuarterTime;
		clockTempo = 60000 / quarterDuration;
		
		calculatedTempos.push(clockTempo);
		
		var len:Int = calculatedTempos.length;
		
		if(len > TEMPOS_FOR_AVERAGE)
		{
			calculatedTempos.shift();
		}
		
		if(len >= TEMPOS_FOR_AVERAGE)
		{
			var tempo:Float = 0;
			var sum:Float = 0;
			
			for(tempo in calculatedTempos)
			{
				sum += tempo;
			}
			
			averageTempo = sum / calculatedTempos.length;
		}
		else
		{
			averageTempo = clockTempo;
		}
	}
	
	override function handleMessage(message:Message):Void
	{
		var systemMessage:SystemMessage = message as SystemMessage;
		
		switch(systemMessage.type)
		{
			case SystemMessageType.TIMING_CLOCK:
				handleClock(systemMessage);
				break;
			case SystemMessageType.START:
				handleStart(systemMessage);
				break;
			case SystemMessageType.SONG_POSITION:
				handlePosition(systemMessage);
				break;
			case SystemMessageType.STOP:
				handleStop(systemMessage);
				break;
			case SystemMessageType.CONTINUE:
				handleContinue(systemMessage);
				break;
			default:
				throw new Error("Unrecognized system message: " + systemMessage);
		}
	}
	
	function handleClock(message:SystemMessage):Void
	{
		count++;
		
		// dispatch clock event
		dispatchEvent(new ClockEvent(ClockEvent.CLOCK));
		
		// update position if not stopped
		if(!isStopped && count % CLOCKS_PER_BEAT == 0)
		{
			currentBeat++;
		}
		
		if(count % timingDivision == 0)
		{
			dispatchEvent(new ClockEvent(ClockEvent.BEAT));
		}
		
		if(count == CLOCKS_PER_QUARTER)
		{
			previousQuarterTime = quarterTime;
			quarterTime = getTimer();//message.time;
			calculateTempo();
			count = 0;
		}
	}

	function handleStart(message:SystemMessage):Void
	{
		currentBeat = 0;
		count = 0;
		isStopped = false;
		dispatchEvent(new ClockEvent(ClockEvent.START));
	}
	
	function handleContinue(message:SystemMessage):Void
	{
		isStopped = false;
		dispatchEvent(new ClockEvent(ClockEvent.START));
	}
	
	function handlePosition(message:SystemMessage):Void
	{
		currentBeat = message.combinedData;
		count = (currentBeat * CLOCKS_PER_BEAT) % CLOCKS_PER_QUARTER;
		
		dispatchEvent(new ClockEvent(ClockEvent.POSITION));
	}
	
	function handleStop(message:SystemMessage):Void
	{
		isStopped = true;
		dispatchEvent(new ClockEvent(ClockEvent.STOP));
	}
}
