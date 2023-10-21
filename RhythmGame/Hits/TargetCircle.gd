extends ColorRect

const THICKNESS := 0.015

var shrink_speed := 0.0

var _radius := 0.0
var _start_radius := 0.0
var _end_radius := 0.0

func setup(radius_start: float, radius_end: float, bps: float, beat_delay: float):
	_radius = radius_start
	_start_radius = radius_start
	_end_radius = radius_end
	
	# TODO: review bps vs beat_duration
	shrink_speed = (1.0 / bps) / beat_delay * (_radius - _end_radius)
	
	# Godot 3 -> 4 .. `margin_{x}` -> `offset_{x}`
	offset_left = -_radius
	offset_right = _radius
	offset_top = -_radius
	offset_bottom = _radius
	
	# Godot 3 -> 4 .. `rect_size` -> `size` .. great helper input from compiler, thx
	size = Vector2.ONE * _radius * 2

func _process(delta: float):
	_radius -= delta * shrink_speed
	
	if _radius < 70:
		print("ID = ", get_instance_id(), " _radius = ", _radius)
	
	
	var torus_radius = _radius / _start_radius / 2
	material.set_shader_parameter("torus_radius", torus_radius)
	
	if _radius <= _end_radius:
		_radius = _end_radius
		set_process(false)
	
