@tool # lets us run code in Godot Editor
# godot4 declaration vs godot 3
@icon("res://RhythmGame/Editor/placer_hit_beat_icon.svg")

extends Node2D

class_name PlacerHitBeat

@export var scene: PackedScene
@export var duration := 2:
	set(value):
		duration = value
		$Sprite2D.frame = duration - 1
	get:
		return duration

var _order_number = 1

func _enter_tree():
	_order_number = get_index() + 1
	$OrderNumber.text = str(_order_number)

func get_data() -> Dictionary:
	return {
		scene = scene,
		order_number = _order_number,
		global_position = global_position,
		duration = duration,
	}
