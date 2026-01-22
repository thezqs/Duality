extends Control

class_name LineEditor

## Nota Seleccionada actualmente
var note_select: Note = null

## Define si se esta en modo arrastre
var darg: = false

func _ready() -> void:
	var stream: AudioStream = %AudioStreamPlayer.stream
	var stream_seconds = stream.get_length()
	
	@warning_ignore("integer_division")
	var stream_beats = stream_seconds * (Editor.bpm / 60)
	var stream_steps = stream_beats * 16
	Editor.song_px_size = stream_steps * Editor.PX_PER_STEP


func _on_time_spin_box_value_changed(value: float) -> void:
	if darg: return
	
	


func _on_position_x_spin_box_value_changed(value: float) -> void:
	if darg: return
	


func _on_delete_note_button_pressed() -> void:
	pass # Replace with function body.
