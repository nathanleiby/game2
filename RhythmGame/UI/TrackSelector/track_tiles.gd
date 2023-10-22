extends Node2D

@export var tracks: Array[Resource]
@export var track_tile_scene: PackedScene
@export var separation := 450

var _track_tiles := []

func _ready():
	_generate_tiles()
	
func _generate_tiles():
	var offset := 0.0
	# for i in range(tracks.size()):
	print(tracks)
	for track_data in tracks:
		# var track_data: TrackData = tracks[i]
		# TODO: How to get TrackTile type in current scope
		var track_tile: TrackTile = track_tile_scene.instantiate()
		print(track_data.as_dict())
	
		track_tile.track_data = track_data
		_track_tiles.append(track_tile)
		track_tile.position = Vector2(offset, 0)
		offset += separation
		
		add_child(track_tile)
