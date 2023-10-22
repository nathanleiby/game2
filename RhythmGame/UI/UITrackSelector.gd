extends Control

var _current_track_data: TrackData

@onready var _track_name := $TrackName
@onready var _stream := $AudioStreamPlayer
@onready var _animation_player := $AnimationPlayer

func _ready():
	update_track_info($Centered/TrackCarousel/TrackTiles.get_child(0))
	
func update_track_info(track_tile: TrackTile):
	_current_track_data = track_tile.track_data
	_track_name.text = _current_track_data.label
	
	_animation_player.play("fade_out_track")
	await _animation_player.animation_finished # Godot 4. Was yield
	_stream.stream = load(_current_track_data.stream)
	_stream.play(30.0)
	_animation_player.play("fade_in_track")
	
func _on_go_button_pressed():
	Events.emit_signal("track_selected", _current_track_data.as_dict())
	queue_free()
