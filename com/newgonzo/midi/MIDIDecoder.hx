package com.newgonzo.midi;

import com.newgonzo.midi.errors.InvalidFormatError;
import com.newgonzo.midi.file.MIDIFile;
import com.newgonzo.midi.file.MIDITrack;
import com.newgonzo.midi.file.MIDITrackEvent;
import com.newgonzo.midi.file.messages.EndTrackMessage;
import com.newgonzo.midi.file.messages.KeySignatureMessage;
import com.newgonzo.midi.file.messages.MetaEventMessageType;
import com.newgonzo.midi.file.messages.PortNumberMessage;
import com.newgonzo.midi.file.messages.SequenceNumberMessage;
import com.newgonzo.midi.file.messages.SetTempoMessage;
import com.newgonzo.midi.file.messages.TextMessage;
import com.newgonzo.midi.file.messages.TimeSignatureMessage;
import com.newgonzo.midi.messages.ChannelMessage;
import com.newgonzo.midi.messages.InvalidMessage;
import com.newgonzo.midi.messages.Message;
import com.newgonzo.midi.messages.MessageStatus;
import com.newgonzo.midi.messages.SystemExclusiveMessage;
import com.newgonzo.midi.messages.SystemMessage;
import com.newgonzo.midi.messages.SystemMessageType;
import com.newgonzo.midi.messages.VoiceMessage;
import flash.utils.ByteArray;

class MIDIDecoder {
	
	public static var MIDI_FILE_HEADER_TAG:UInt = 0x4D546864; // MThd
	public static var MIDI_FILE_HEADER_SIZE:UInt = 0x00000006;
	public static var MIDI_TRACK_HEADER_TAG:UInt = 0x4D54726B; // MTrk
	
	public function new () { }
	
	@:noDebug
	public function decodeFile (data:ByteArray) :MIDIFile {
		data.endian = flash.utils.Endian.BIG_ENDIAN;
		var head = data.readInt();
		if (head != cast(MIDI_FILE_HEADER_TAG)) {
			throw new InvalidFormatError("Invalid MIDI header tag: expected 0x4D546864 (MThd) vs :"+	head);
		}
		
		if (data.readInt() != cast(MIDI_FILE_HEADER_SIZE)) {
			throw new InvalidFormatError("Invalid MIDI header size: expected 0x00000006");
		}
		
		var format:UInt = data.readShort();
		var numTracks:UInt = data.readShort();
		var timeDivision:UInt = data.readShort();
		
		var tracks:Array<MIDITrack> = new Array<MIDITrack>();
		var track:MIDITrack;
		var trackHeader:Int;
		var trackSize:UInt;
		var trackEnd:UInt;
		var trackTime:UInt;
		
		var events:Array<MIDITrackEvent>;
		var event:MIDITrackEvent;
		var eventDelta:UInt;
		
		var messageBytes:ByteArray;
		var message:Message;
		
		// for midi running status
		var previousStatusByte:UInt = 0;
		
		// decode tracks
		var i:UInt = 0;
		
		for (i in 0...numTracks) {
			events = new Array<MIDITrackEvent>();
			
			trackHeader = data.readInt();
			
			// last byte might be a null byte
			if (data.bytesAvailable == 0)	break;
			
			if (trackHeader != cast(MIDI_TRACK_HEADER_TAG)) {
				throw new InvalidFormatError("Invalid MIDI track header tag at track "  + i + ": expected 0x4D54726B (MTrk)");
			}
			
			trackSize = data.readInt();
			trackEnd = data.position + trackSize;
			trackTime = 0;
			
			while (cast(data.position) < trackEnd) {
				eventDelta = readVariableLengthUint(data);
				
				trackTime += eventDelta;
				
				if (MessageStatus.isStatus(data[data.position] & 0xF0)) {
					previousStatusByte = data[data.position];
				}
				
				message = decodeMessage(data, true, previousStatusByte);
				
				event = new MIDITrackEvent(trackTime, message);
				events.push(event);
			}
			
			track = new MIDITrack(events);
			tracks.push(track);
		}
		
		return new MIDIFile(format, timeDivision, tracks);
	}
	
	public function decodeMessages (data:ByteArray) :Array<Message> {
		var messages:Array<Message> = new Array<Message>();
		while (data.bytesAvailable > 0) {
			messages.push(decodeMessage(data));
		}
		return messages;
	}
	
	public function decodeMessage (data:ByteArray, inFile:Bool = false, previousStatusByte:UInt = 0) :Message {
		var byte:UInt;
		var status:UInt;
		var lsb:UInt;
		
		// Need to use the bytes as unsigned. This can be done
		// by using ByteArray's readUnsignedByte() or by masking
		// the bits we care about: readByte() & OxFF
		byte = data.readUnsignedByte();
		
		// isolate the first and second 4-bits
		status = byte & 0xF0;
		
		// for midi running status: see http://everything2.com/user/arfarf/writeups/MIDI+running+status
		if (inFile && !MessageStatus.isStatus(status)) {
			// back up the data stream
			data.position--;
			byte = previousStatusByte;
			status = byte & 0xF0;
		}
		
		// channel or system message type
		lsb = byte & 0x0F;
		
		// MIDI Realtime messages can appear ANYWHERE, even
		// between the two data bytes of a Voice message.
		// TODO: set up handling of real time messages
		
		switch (status) {
			case MessageStatus.NOTE_ON, MessageStatus.NOTE_OFF, MessageStatus.KEY_PRESSURE:
				return new VoiceMessage(status, lsb, data.readUnsignedByte(), data.readUnsignedByte());
				
			case MessageStatus.CONTROL_CHANGE, MessageStatus.PITCH_BEND:
				return new ChannelMessage(status, lsb, data.readUnsignedByte(), data.readUnsignedByte());
			
			case MessageStatus.PROGRAM_CHANGE, MessageStatus.CHANNEL_PRESSURE:
				return new ChannelMessage(status, lsb, data.readUnsignedByte());
				
			case MessageStatus.SYSTEM:
				return createSystemMessage(lsb, data, inFile);
				
			default:// not supported or some major problem
				return new InvalidMessage(status);
		}
	}
	
	function createSystemMessage (type:Int, data:ByteArray, inFile:Bool = false) :Message {
		switch (type) {
			case SystemMessageType.SONG_POSITION:
				return new SystemMessage(type, data.readUnsignedByte(), data.readUnsignedByte());
			
			case SystemMessageType.SONG_SELECT:
				return new SystemMessage(type, data.readUnsignedByte());
				
			case SystemMessageType.SYSTEM_RESET:
				return inFile ? createMetaEventMessage(data) : new SystemMessage(type);
				
			case SystemMessageType.SYS_EX_START:
				return createSystemExclusiveMessage(type, data);
				
			default:
				return new SystemMessage(type);
		}
	}
	
	function createMetaEventMessage (data:ByteArray) :Message {
		var type:UInt = data.readUnsignedByte();
		var len:UInt = readVariableLengthUint(data);
		
		switch (type) {
			case MetaEventMessageType.TEXT,
				MetaEventMessageType.COPYRIGHT,
				MetaEventMessageType.TRACK_NAME,
				MetaEventMessageType.INSTRUMENT_NAME,
				MetaEventMessageType.LYRIC,
				MetaEventMessageType.MARKER,
				MetaEventMessageType.CUE_POINT,
				MetaEventMessageType.PROGRAM_NAME,
				MetaEventMessageType.DEVICE_NAME:
				return new TextMessage(type, data.readUTFBytes(len));
			
			case MetaEventMessageType.MIDI_PORT:
				return new PortNumberMessage(data.readUnsignedByte());
				
			case MetaEventMessageType.SET_TEMPO:
				return createSetTempoMessage(data);
				
			case MetaEventMessageType.KEY_SIGNATURE:
				return createKeySignatureMessage(data);
				
			case MetaEventMessageType.TIME_SIGNATURE:
				return createTimeSignatureMessage(data);
				
			case MetaEventMessageType.END_OF_TRACK:
				return EndTrackMessage.END_OF_TRACK;
				
			case MetaEventMessageType.SEQUENCE_NUM:
				return new SequenceNumberMessage(data.readUnsignedByte(), data.readUnsignedByte());
			
			default:
				return InvalidMessage.INVALID;
		}
	}
	
	function createSetTempoMessage (data:ByteArray) :Message {
		var a:UInt = data.readUnsignedByte();
		var b:UInt = data.readUnsignedByte();
		var c:UInt = data.readUnsignedByte();
		
		var micros:UInt = c | (b << 8) | (a << 16);
		
		return new SetTempoMessage(micros);
	}
	
	function createSystemExclusiveMessage (type:UInt, data:ByteArray) :Message {
		var len:UInt = readVariableLengthUint(data);
		var bytes:ByteArray = new ByteArray();
		
		// read all but the last 0xF7 into the data bytes for this SysEx
		data.readBytes(bytes, 0, len - 1);
		
		// gobble the trailing 0xF7
		if (data.readUnsignedByte() != 0xF7) {
			throw new InvalidFormatError("SysEx messages must be terminated by 0xF7");
		}
		return new SystemExclusiveMessage(type, bytes);
	}
	
	function createKeySignatureMessage (data:ByteArray) :Message {
		var numAccidentals:Int = data.readByte();
		
		// 0 for major, 1 for minor
		var isMinor:Bool = data.readUnsignedByte() == 1;
		
		return new KeySignatureMessage(numAccidentals, isMinor);
	}
	
	function createTimeSignatureMessage (data:ByteArray) :Message {
		var numerator:UInt = data.readUnsignedByte();
		var denominator:UInt = cast(Math.pow(2, data.readUnsignedByte()));// time sig denominator is represented as the power to which 2 should be raised
		var clocksPerClick:UInt = data.readUnsignedByte();
		var thirtySecondthsPerQuarter:UInt = data.readUnsignedByte();
		
		return new TimeSignatureMessage(numerator, denominator, clocksPerClick, thirtySecondthsPerQuarter);
	}
	
	function readVariableLengthUint (data:ByteArray) :UInt {
		var temp:ByteArray = new ByteArray();
		var byte:Int;
		
		do {
			byte = data.readByte();
			temp.writeByte(byte);
		}
		while (byte & 0x80 != 0);
		
		var value:UInt = 0;
		var e:Int = temp.length - 1;
		
		temp.position = 0;
		
		while (e >= 0) {
			value += (temp.readByte() & 0x7F) << (7*e);
			e--;
		}
		
		return value;
	}
	
}
