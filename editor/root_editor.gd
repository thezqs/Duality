extends Control

class_name LineEditor

signal select_changed(new_node: Node2D)

func _ready() -> void:
	var stream: AudioStream = %AudioStreamPlayer.stream
	var stream_seconds = stream.get_length()
	
	@warning_ignore("integer_division")
	var stream_beats = stream_seconds * (Editor.bpm / 60)
	var stream_steps = stream_beats * 16
	Editor.song_px_size = stream_steps * Editor.PX_PER_STEP
