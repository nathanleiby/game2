extends Marker2D

const FRAME_OK = 1
const FRAME_GREAT = 2
const FRAME_PERFECT = 3

@onready var _sprite := $Sprite2D
@onready var _particles := $GPUParticles2D

func _ready():
	# https://gist.github.com/WolfgangSenff/168cb0cbd486c8c9cd507f232165b976?permalink_comment_id=4530151#gistcomment-4530151
	top_level = true
	# set_as_top_level(true) # was "set_as_toplevel"

func setup(global_pos: Vector2, score: int):
	global_position = global_pos
	# TODO: potentially some better way to import this score mapping vs need the score values here too (see also HitBeat.gd)
	if score >= 10:
		_sprite.frame = FRAME_PERFECT
		_particles.emitting = true
	elif score >= 5:
		_sprite.frame = FRAME_GREAT
	elif score >= 3:
		_sprite.frame = FRAME_OK
		
