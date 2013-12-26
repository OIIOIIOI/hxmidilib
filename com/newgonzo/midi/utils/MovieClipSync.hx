package com.newgonzo.midi.utils;

import com.newgonzo.midi.MIDIClock;
import com.newgonzo.midi.events.ClockEvent;
import flash.display.MovieClip;

/**
 * This class can be used to sync a MovieClip timeline to MIDI clock.
 */
class MovieClipSync {
	
	// 24 is a good default b/c there are 24 MIDI clocks per quarter note beat
	public static var DEFAULT_FRAMES_PER_BEAT:UInt = 24;
	
	var midiClock:MIDIClock;
	
	var clipTimeline:MovieClip;
	var clipFrameRate:UInt = 0;
	
	var midiPositionOffset:Float = 0;
	var clipFrameOffset:UInt = 0;
	
	var synced:Bool = true;
	
	public function new (clock:MIDIClock, timeline:MovieClip = null, framesPerBeat:UInt = 0, positionOffset:Float = 0, frameOffset:UInt = 0) {
		midiClock = clock;
		clipTimeline = timeline;
		clipFrameRate = framesPerBeat ? framesPerBeat : DEFAULT_FRAMES_PER_BEAT;
		
		midiPositionOffset = positionOffset;
		clipFrameOffset = frameOffset;
		
		initSync();
		updateSync();
	}
	
	public function get clock () :MIDIClock {
		return midiClock;
	}
	
	public function get timeline () :MovieClip {
		return clipTimeline;
	}
	public function set timeline (value:MovieClip) :Void {
		clipTimeline = value;
		updateSync();
	}
	
	public function get syncEnabled () :Bool {
		return synced;
	}
	public function set syncEnabled (value:Bool) :Void {
		synced = value;
	}

	function initSync () :Void {
		midiClock.addEventListener(ClockEvent.CLOCK, handleMidiClock, false, 0, true);
		midiClock.addEventListener(ClockEvent.POSITION, handleMidiPosition, false, 0, true);
	}
	
	function updateSync () :Void {
		if(clipTimeline == null)	return;
		
		var pos:Float = (midiClock.position + 1) + midiPositionOffset;
		var frame:Float = 1 + Math.round((pos * clipFrameRate) + clipFrameOffset);
		
		if (frame > clipTimeline.totalFrames) {
			frame %= clipTimeline.totalFrames;
		}
		
		if (synced && clipTimeline.currentFrame != frame) {
			clipTimeline.gotoAndStop(frame);
		}
	}
	
	function handleMidiClock (e:ClockEvent) :Void {
		updateSync();
	}
	
	function handleMidiPosition (e:ClockEvent) :Void {
		updateSync();
	}
	
}
