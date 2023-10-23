extends Area2D

signal track_selected(track_tile)

var _last_tile_selected = null

func _on_area_entered(area: Area2D):
	if _last_tile_selected != area:
		emit_signal("track_selected", area)
	_last_tile_selected = area
