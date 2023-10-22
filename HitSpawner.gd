extends Node

@export var enabled := true
@export var hit_beat: PackedScene

const MAX_X: int = 1920
const MAX_Y: int = 1080

var _stack_current = [] # array of dicts representing what to spawn

func _spawn_beat(msg: Dictionary):
	if not enabled:
		return
	
	# song is done
	if _stack_current.is_empty(): # empty() -> is_empty()
		enabled = false
		Events.emit_signal("track_finished")
		return
	
	var hit_beat_data: Dictionary = _stack_current.pop_front()
	if not hit_beat_data.has('global_position'):
		# we add empty dicts into the stack to denote "no note for this beat"
		return
		
	# add extra information
	hit_beat_data.half_beat = msg.half_beat
	hit_beat_data.beat_duration = msg.beat_duration
	hit_beat_data.color = randi_range(0, 5) # TODO: missing in tutorial but implied?
	
	var new_beat: Node = hit_beat.instantiate() # instance() -> instantiate() 
	add_child(new_beat)
	new_beat.setup(hit_beat_data)
	
func _ready():
	Events.connect("half_beat_incremented", _spawn_beat)
	
	# TODO: testing..
	_generate_stack()

func _generate_stack():
	for i in range(10):
		var hit_beat_data = {}
		if i % 2 == 1:
			hit_beat_data.color = randi_range(0,5) # was: int(rand_range(0,5))
			hit_beat_data.global_position = i * Vector2(100, 100)
		
		_stack_current.append(hit_beat_data)
