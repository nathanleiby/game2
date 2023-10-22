extends Node

@export var bpm = 124

var _beat_duration = 60.0 / bpm # seconds per beat .. (60 seconds / 1 minute) * (minutes / beat) = (seconds per beat)
var _half_beat_duration = _beat_duration * 0.5
var _last_beat = 0
var _last_half_beat = 0

@onready var _stream: AudioStreamPlayer = $AudioStreamPlayer

func play_audio():
	var time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	await get_tree().create_timer(time_delay).timeout # godot 3 -> 4 .. https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#awaiting-for-signals-or-coroutines
	_stream.play()

func _ready():
	Events.connect("track_selected", _load_track)
	
func _load_track(msg: Dictionary):
	print("_load_track:", msg)
	# set speed
	bpm = msg.bpm
	_beat_duration = 60.0 / bpm
	_half_beat_duration = _beat_duration * 0.5
	
	play_audio()

func _process(_delta: float) -> void:
	# https://docs.godotengine.org/en/stable/tutorials/audio/sync_with_audio.html#using-the-sound-hardware-clock-to-sync
	var time: float = _stream.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
	var half_beat = int(time / _half_beat_duration)
	var beat = int(time / _beat_duration)
		
	if half_beat > _last_half_beat:
		_last_half_beat = half_beat
		# print("update _last_half_beat = ", _last_half_beat)
		
		Events.emit_signal("half_beat_incremented", {"half_beat": half_beat, "beat_duration": _beat_duration})
	
