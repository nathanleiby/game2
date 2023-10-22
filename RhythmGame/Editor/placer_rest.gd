@tool
@icon("res://RhythmGame/Editor/placer_rest_icon.svg")
extends Node2D

class_name PlacerRest

@export var duration := 2:
	set(value):
		duration = value
		$Sprite2D.frame = duration - 1
	get:
		return duration
		
var _order_number := 1

func _enter_tree():
	_order_number = get_index() + 1
	$OrderNumber.text = str(_order_number)

func get_data() -> Dictionary:
	return {duration = duration}

