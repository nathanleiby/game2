extends Sprite2D

const _start_scale := Vector2.ONE * 1.5
const _end_scale := Vector2.ONE

func _ready():
	Events.connect("half_beat_incremented", _pulse)

func _pulse(msg: Dictionary):
	# only pulse every beat
	if msg.half_beat % 2 == 1:
		return
	
	var _beat_duration: float = msg.beat_duration

	# translated to Godot 4 style
	# - https://docs.godotengine.org/en/stable/classes/class_tween.html
	# - https://docs.godotengine.org/en/stable/classes/class_propertytweener.html#class-propertytweener
	# - bugfixing: https://godotforums.org/d/36179-attempt-to-call-tween-property-in-base-null-instance-on-a-null-instance/3
	var _tween = create_tween()
	_tween.set_trans(Tween.TRANS_LINEAR)
	_tween.set_ease(Tween.EASE_OUT)
	_tween.tween_property(self, "scale", _end_scale, _beat_duration / 4).from(_start_scale)
	
