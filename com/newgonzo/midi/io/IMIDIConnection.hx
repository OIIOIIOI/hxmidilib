package com.newgonzo.midi.io;

import flash.events.IEventDispatcher;
import flash.utils.ByteArray;

public interface IMIDIConnection extends IEventDispatcher {
	
	function sendBytes (value:ByteArray) :Void
	function receiveBytes (value:ByteArray) :Void
	var connected(default, null):Bool
	function connect (...args) :Void
	function close () :Void
}
