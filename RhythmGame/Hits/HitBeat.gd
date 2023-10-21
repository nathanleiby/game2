extends Node2D
	

var _beat_hit := false

@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _sprite := $Sprite2D
@onready var _touch_area := $Area2D
@onready var _label := $LabelCustom
@onready var _target_circle := $TargetCircle
	
# Scoring
const SCORE_PERFECT := 10
const SCORE_GREAT := 5
const SCORE_OK := 3

const OFFSET_PERFECT := 4
const OFFSET_GREAT := 8
const OFFSET_OK := 16

const RADIUS_START := 150.0
const RADIUS_PERFECT := 70.0

# duration in beats for target circle to shrink
const BEAT_DELAY := 4.0

# radius of animated ring around note
var _radius := RADIUS_START
# speed at which target circle shrinks in pixels per second
var _speed  := 0.0

func _ready():
	_animation_player.play("show")

func setup(data: Dictionary):
	self.order_number = data.half_beat
	global_position = data.global_position
	_sprite.frame = data.color
	_speed = 1.0 / data.beat_duration / BEAT_DELAY
	_target_circle.setup(RADIUS_START, RADIUS_PERFECT, data.beat_duration, BEAT_DELAY)

func _process(delta: float):
	if _beat_hit:
		return
		
	_radius -= delta * (RADIUS_START - RADIUS_PERFECT) * _speed
	
	# The note has expired
	if _radius <= RADIUS_PERFECT - OFFSET_PERFECT:
		# disable further collisions by removing physics layer
		_touch_area.collision_layer = 0
		_beat_hit = true 
		
		Events.emit_signal("scored", {"score": 0, "position": global_position})
		_animation_player.play("destroy")
		
		
func _on_area_2d_input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("touch"):
		# disable further collisions by removing physics layer
		_touch_area.collision_layer = 0
		_beat_hit = true
		
		Events.emit_signal("scored", {"score": _get_score(), "position": global_position})
		# run destroy animation (which calls queue_free() at the end)
		_animation_player.play("destroy")
		

func _get_score() -> int:
	var offset = abs(RADIUS_PERFECT - _radius)
	if offset < OFFSET_PERFECT:
		return SCORE_PERFECT
	elif offset < OFFSET_GREAT:
		return SCORE_GREAT
	elif offset < OFFSET_OK:
		return SCORE_OK
	else:
		return 0
		
# TODO: setget syntax converted Godot 3 -> 4 .. works?
@export var order_number: int = 0:
	get:
		return order_number
	set(val):
		# make the setter also handle keeping the label text in sync
		order_number = val
		# TODO: can this refer to _label?
		_label.text = str(order_number)
