extends Node2D

# Using the Inspector, we provide our source scene to instantiate it when the
# player taps a button.
@export var sprite_fx: PackedScene

# We connect to the `Events.scored` signal.
func _ready() -> void:
	Events.connect("scored", _create_score_fx)

func _create_score_fx(msg: Dictionary) -> void:
	var new_sprite_fx := sprite_fx.instantiate()
	add_child(new_sprite_fx)
	new_sprite_fx.setup(msg.position, msg.score)
