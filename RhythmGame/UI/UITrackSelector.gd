extends Control

var _current_track_data: TrackData

@onready var _track_name := $TrackName
@onready var _stream := $AudioStreamPlayer
@onready var _animation_player := $AnimationPlayer

func _ready():
	# set a default track
	update_track_info($TrackCarousel/TrackTiles/Tracks.get_child(0))
	
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

func _on_select_area_track_selected(track_tile):
	update_track_info(track_tile)
