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
	WIGGLE = position.x # TODO: can remove?
	_generate_tiles()
	_update_tile_visuals()
	
	
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
	_update_tile_visuals()
	
func _process(_delta: float):
	if _tween != null and _tween.is_running():
		_update_tile_visuals()
	
func _on_drag_detector_dragged(amount):
	scroll(amount)

func _snap_to_track(track_tile: TrackTile):
	var offset_to_center := Vector2(get_parent().global_position.x - track_tile.global_position.x, 0)
	
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_OUT)
	_tween.set_trans(Tween.TRANS_EXPO)
	_tween.tween_property(self, "position", position + offset_to_center, 0.5).from_current()
	
	
func _on_select_area_track_selected(track_tile: TrackTile):
	_selected_track_tile = track_tile

func _unhandled_input(event: InputEvent):
	if event.is_action_released("touch"):
		_align_timer.start()

func _on_align_timer_timeout():
	_snap_to_track(_selected_track_tile)

func _update_tile_visuals():
	var carousel_position_x: float = get_parent().global_position.x
	
	var viewport_boundary_with_margin := get_viewport_rect().grow(200.0)
	for track_tile in _track_tiles:
		if not viewport_boundary_with_margin.has_point(track_tile.global_position):
			# perf improvement -- skip tiles outside viewport
			# Alternative approach: VisibilityEnabler2d / VisibilityNotifier2D
			continue
		
		var distance_to_view_center: float = abs(track_tile.global_position.x - carousel_position_x)
		
		var distance_normalized = remap(distance_to_view_center, 0.0, carousel_position_x, 0.0, 1.0)
		
		track_tile.scale = Vector2.ONE * (1.0 - distance_normalized)
		track_tile.modulate.a = (1.0 - pow(distance_normalized, 3.0)) 
		
