class_name TrackTile

extends Area2D


var track_data: TrackData:
	set(value):
		track_data = value
		$Sprite2D.texture = track_data.icon
	get:
		return track_data
		
