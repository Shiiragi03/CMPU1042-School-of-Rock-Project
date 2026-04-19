extends Node2D

const OCTAVES = 6
const WHITE_PER_OCTAVE = 7
const TOTAL_WHITE = OCTAVES * WHITE_PER_OCTAVE
const C0 = 24

var white_w = 0.0
var black_w = 0.0
var black_h = 0.0

var has_black = [true, true, false, true, true, true, false]

var last_note = -1

var sequence = []
var rec = false

func _input(event):
	var note = -1

	if event is InputEventMouseButton and event.pressed:
			note = calculate_note(event.position)
			play_note(note, 0.25, 0)
			
			if rec:
				sequence.append(note)


func calculate_note(pos):
	var vs = get_viewport_rect().size

	white_w = vs.x / TOTAL_WHITE
	black_w = white_w * 0.6
	black_h = vs.y * 0.6/1.5

	var note = -1

	var black_offset = [1,3,-1,6,8,10,-1]
	var white_offset = [0,2,4,5,7,9,11]
	for i in TOTAL_WHITE:
		var note_index = i % 7
		
		if black_offset[note_index] != -1:
			var x = (i + 1) * white_w - black_w/2
			
			var rect = Rect2(x,0,black_w, black_h/1.5)
			
			if rect.has_point(pos):
				var octave = i / 7
				note = C0 + octave * 12 + black_offset[note_index]
				
	if note == -1:
		
		for i in range(TOTAL_WHITE):
			var x = i * white_w
			
			var rect = Rect2(x, 0, white_w, vs.y/1.5)
			
			if rect.has_point(pos):
				var octave = i / 7
				var note_index = i % 7
				
				note = C0 + octave * 12 + white_offset[note_index]
	return note

func play_note(note, duration, channel):
	note = note % 127

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



func _process(delta):
	queue_redraw()

func _draw():
	var vs = get_viewport_rect().size
	white_w = vs.x / TOTAL_WHITE

	for i in range(TOTAL_WHITE):
		var x = i * white_w
		draw_rect(Rect2(x, 0, white_w, vs.y/1.5), Color.WHITE)
		draw_rect(Rect2(x, 0, white_w, vs.y/1.5), Color.BLACK, false, 2)

	for i in range(TOTAL_WHITE):
		var idx = i % 7

		if has_black[idx]:
			var x = (i + 1) * white_w - white_w * 0.3
			draw_rect(Rect2(x, 0, white_w * 0.6, vs.y * 0.6/1.5), Color.BLACK)


func _on_check_box_toggled(toggled_on):
	rec = toggled_on
	
	if rec:
		sequence.clear()

func play_seq():
	for note in sequence:
		play_note(note,0.3,0)
		await get_tree().create_timer(0.35).timeout


func _on_button_pressed() -> void:
	play_seq()
