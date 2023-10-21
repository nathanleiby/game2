extends Label

var _total_score := 0

func _ready():
	Events.connect("scored", _add_score)
	
func _add_score(msg: Dictionary):
	_total_score += msg.score
	text = str(_total_score)
	
