extends Control

@onready var _animation_player := $AnimationPlayer

func _ready():
	Events.connect("track_finished", _on_events_track_finished)
	
func _on_events_track_finished():
	print("show()")
	_animation_player.play("show")
	
func _on_button_back_pressed():
	get_tree().reload_current_scene()
