extends Node2D


# TODO: setget syntax converted Godot 3 -> 4 .. works?
@export var order_number: int = 0:
	get:
		return order_number
	set(val):
		# make the setter also handle keeping the label text in sync
		order_number = val
		_label.text = str(order_number)
	

var _beat_hit := false

@onready var _animation_player := $AnimationPlayer
@onready var _sprite := $Sprite2D
@onready var _touch_area := $Area2D
@onready var _label := $Label
	
func _ready():
	_animation_player.play("show")

func setup(data: Dictionary):
	self.order_number = data.half_beat
	global_position = data.global_position
	_sprite.frame = data.color
	


func _on_area_2d_input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("touch"):
		_beat_hit = true
		# disable further collisions by removing physics layer
		_touch_area.collision_layer = 0
		# run destroy animation (which calls queue_free() at the end)
		_animation_player.play("destroy")
		
