class_name TrackData

extends Resource

@export var label := "Track Name"
@export_file("*.ogg") var stream # updated to @export_file syntax for Godot 4 https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html
@export var bpm := 1
@export var icon: Texture
@export var artist := "Artist"

func as_dict() -> Dictionary:
	return {"name": label, "stream": stream, "bpm": bpm, "icon": icon, "artist": artist}
