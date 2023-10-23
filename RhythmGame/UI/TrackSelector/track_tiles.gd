extends Node2D

@export var tracks: Array[Resource]
@export var track_tile_scene: PackedScene
@export var separation := 450

@onready var _align_timer = $AlignTimer

var _selected_track_tile: TrackTile

var _track_tiles := []
var WIGGLE := 0 # _starting_x_offset = 0.0 
var _tween: Tween

func _ready():
	WIGGLE = position.x
	_generate_tiles()
	
	
var _min_x_position := 0
var _max_x_position := 0

func _generate_tiles():
	var offset := 0.0
	for track_data in tracks:
		# How to get TrackTile type in current scope? by declaring a class_name in another file
		var track_tile: TrackTile = track_tile_scene.instantiate()
		print(track_data.as_dict())
	
		track_tile.track_data = track_data
		_track_tiles.append(track_tile)
		track_tile.position = Vector2(offset, 0)
		offset += separation
		
		$Tracks.add_child(track_tile)
	
	
	_min_x_position = -(separation * (_track_tiles.size() -1)) + WIGGLE
	_max_x_position = 0 + WIGGLE

	# start in the middle
	position.x = (_min_x_position + _max_x_position) / 2


func scroll(amount: Vector2):
	position.x = clamp(position.x + amount.x, _min_x_position, _max_x_position)
	if _tween != null:
		_tween.stop()
	
func _on_drag_detector_dragged(amount):
	scroll(amount)

func _snap_to_track(track_tile: TrackTile):
	var offset_to_center := Vector2(get_parent().global_position.x - track_tile.global_position.x, 0)
	
	var _tween := create_tween()
	_tween.set_ease(Tween.EASE_OUT)
	_tween.set_trans(Tween.TRANS_EXPO)
	_tween.tween_property(self, "position", position + offset_to_center, 0.5).from_current()
	
func _on_select_area_track_selected(track_tile: TrackTile):
	print("_on_select_area_track_selected", track_tile.track_data.label)
	_selected_track_tile = track_tile

func _unhandled_input(event: InputEvent):
	if event.is_action_released("touch"):
		_align_timer.start()

func _on_align_timer_timeout():
	_snap_to_track(_selected_track_tile)
