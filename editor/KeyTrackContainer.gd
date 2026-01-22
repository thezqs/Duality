extends VBoxContainer

class_name KeyTrackContainer

var track_scene: PackedScene = preload("res://editor/KeyTrack/KeyTrack.tscn")

var horizontal_px: float

var px_per_beat: float

func _ready() -> void:
	Editor.connect("song_px_size_changed", _song_px_size_changed)

func _song_px_size_changed(new_size: float):
	custom_minimum_size.x = new_size

func _draw() -> void:
	pass

func _on_add_line_button_pressed() -> void:
	var track_ins = track_scene.instantiate()
	
	add_child(track_ins)

func _on_remove_line_button_pressed() -> void:
	pass # Replace with function body.
