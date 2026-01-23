extends Control

class_name LineEditor

## Nota Seleccionada actualmente
var note_select: Note = null:
	set(new):
		note_select = new
		
		if new != null:
			%NotePropertyContainer.visible = true

## Define si se esta en modo arrastre
var drag: = false

func _ready() -> void:
	Editor.start_editing()
	
	var stream: AudioStream = %AudioStreamPlayer.stream
	var stream_seconds = stream.get_length()
	
	@warning_ignore("integer_division")
	var stream_beats = stream_seconds * (Editor.bpm / 60)
	var stream_steps = stream_beats * 16
	Editor.song_px_size = stream_steps * Editor.PX_PER_STEP
	
	Editor._update_conversion_cache()
	
	%Line.width_multiplicer = 1
	%Line.is_activated = true

func _process(delta: float) -> void:
	if not drag:
		Manager.current_time = %AudioStreamPlayer.get_playback_position()

func _on_time_spin_box_value_changed(value: float) -> void:
	return

func _on_position_x_spin_box_value_changed(value: float) -> void:
	return

func _on_delete_note_button_pressed() -> void:
	pass # Replace with function body.

func _on_sub_viewport_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				var pos_x = event.position.x * 1.5
				
				print(Manager.current_time)
				
				print(Editor.current_time_steps)
				
				var current_time_steps = snapped(Editor.current_time_steps, 1.0)
				var time_init_steps = current_time_steps - Editor.time_before_note
				var time_init_seg = Editor.steps_to_seconds(time_init_steps)
				
				print(time_init_seg)
				print(Editor.steps_to_seconds(current_time_steps))
				
				note_select = %Line.add_note(pos_x, time_init_seg, Editor.steps_to_seconds(current_time_steps) )


func _on_v_slider_drag_ended(value_changed: bool) -> void:
	drag = false

func _on_v_slider_drag_started() -> void:
	drag = true

func _on_v_slider_value_changed(value: float) -> void:
	if drag:
		Manager.current_time = Editor.steps_to_seconds(value)
		%AudioStreamPlayer.seek(Editor.steps_to_seconds(value))
		%AudioStreamPlayer.play(Editor.steps_to_seconds(value))
		await get_tree().process_frame
		%AudioStreamPlayer.stop()
