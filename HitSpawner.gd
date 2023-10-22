extends Node

@export var enabled := true
@export var hit_beat: PackedScene

const MAX_X: int = 1920
const MAX_Y: int = 1080

var _stacks = {}
@onready var patterns := $Patterns

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
	_generate_stacks()
	_select_stack({name="Cephalopod"})

func _select_stack(msg: Dictionary):
	print("select stack", msg)
	# _stack_current = _stacks[msg.name].stack # TODO: error in tuto
	_stack_current = _stacks[msg.name]

func _generate_stacks():
	for pattern in patterns.get_children():
		_stacks[pattern.name] = []
		for chunk in pattern.get_children():
			# assign a random color to each song chunk
			var sprite_frame := randi_range(0, 5)
			for placer in chunk.get_children():
				var hit_beat_data: Dictionary = placer.get_data()
				hit_beat_data.color = sprite_frame
				_stacks[pattern.name].append(hit_beat_data)
	
	patterns.queue_free()
