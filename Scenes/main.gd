extends Node2D

func change_instrument(channel, instrument):
	var midi_event = InputEventMIDI.new()
	midi_event.channel = 0
	midi_event.message = MIDI_MESSAGE_PROGRAM_CHANGE
	midi_event.instrument = instrument
	$MidiPlayer.receive_raw_midi_message(midi_event)
	

func _ready() -> void:
	pass

func play_note(note, duration, channel):
	var m = InputEventMIDI.new()
	m.message = MIDI_MESSAGE_NOTE_ON
	m.pitch = note
	m.velocity = 100
	m.channel = channel
	$MidiPlayer.receive_raw_midi_message(m)	
	await get_tree().create_timer(duration).timeout
	m = InputEventMIDI.new()
	m.message = MIDI_MESSAGE_NOTE_OFF
	m.pitch = note
	m.velocity = 100
	m.channel = channel
	$MidiPlayer.receive_raw_midi_message(m)
	

func _on_c_0_pressed() -> void:
	var m = InputEventMIDI.new()
	m.message = MIDI_MESSAGE_NOTE_ON
	m.pitch = 24
	m.velocity = 100
	m.channel = 0
	play_note(m.pitch, 1, m.channel)


func _on_c_1_pressed() -> void:
	var m = InputEventMIDI.new()
	m.message = MIDI_MESSAGE_NOTE_ON
	m.pitch = 36
	m.velocity = 100
	m.channel = 0
	play_note(m.pitch, 1, m.channel)


func _on_c_2_pressed() -> void:
	var m = InputEventMIDI.new()
	m.message = MIDI_MESSAGE_NOTE_ON
	m.pitch = 48
	m.velocity = 100
	m.channel = 0
	play_note(m.pitch,1, m.channel)


func _on_c_3_pressed() -> void:
	var m = InputEventMIDI.new()
	m.message = MIDI_MESSAGE_NOTE_ON
	m.pitch = 60
	m.velocity = 100
	m.channel = 0
	play_note(m.pitch, 1, m.channel)


func _on_c_4_pressed() -> void:
	var m = InputEventMIDI.new()
	m.message = MIDI_MESSAGE_NOTE_ON
	m.pitch = 72
	m.velocity = 100
	m.channel = 0
	play_note(m.pitch, 1, m.channel)


func _on_c_5_pressed() -> void:
	var m = InputEventMIDI.new()
	m.message = MIDI_MESSAGE_NOTE_ON
	m.pitch = 84
	m.velocity = 100
	m.channel = 0
	play_note(m.pitch, 1, m.channel)


func _on_c_6_pressed() -> void:
	var m = InputEventMIDI.new()
	m.message = MIDI_MESSAGE_NOTE_ON
	m.pitch = 96
	m.velocity = 100
	m.channel = 0
	play_note(m.pitch, 1, m.channel)
