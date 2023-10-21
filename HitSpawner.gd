extends Node

@export var enabled := true
@export var hit_beat: PackedScene

const MAX_X: int = 1920
const MAX_Y: int = 1080

func _spawn_beat(msg: Dictionary):
	if not enabled:
		return
	
	# spawn a hit beat every whole beat (aka 2 half-beats)
	if msg.half_beat % 2:
		return
	
	var beat: Dictionary = {}
	beat.half_beat = msg.half_beat
	beat.color = randi_range(0, 5)
	beat.global_position = Vector2(randi_range(0, MAX_X), randi_range(0, MAX_Y))
	beat.beat_duration = msg.beat_duration
	
	var new_beat: Node = hit_beat.instantiate() # instance() -> instantiate() 
	add_child(new_beat)
	new_beat.setup(beat)
	
func _ready():
	Events.connect("half_beat_incremented", _spawn_beat)
