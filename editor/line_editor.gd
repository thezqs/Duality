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
	var new_song = SongResource.new()
	
	new_song.audio = %AudioStreamPlayer.stream
	
	Editor.start_editing(new_song)
	
	%Line.width_multiplicer = 1
	%Line.is_activated = true
	
	%TimeVSilder.max_value = Editor.song_steps_size

func _process(delta: float) -> void:
	if not drag and %AudioStreamPlayer.playing:
		Manager.current_time = %AudioStreamPlayer.get_playback_position()
		%TimeVSilder.value = Editor.current_time_steps

func _on_time_spin_box_value_changed(value: float) -> void:
	return

func _on_position_x_spin_box_value_changed(value: float) -> void:
	return

func _on_delete_note_button_pressed() -> void:
	pass # Replace with function body.

func _on_sub_viewport_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					var pos_x = (event.position.x - 288) * 2
					
					var current_time_steps = snapped(Editor.current_time_steps, 1.0)
					var time_init_steps = current_time_steps - Editor.time_before_note
					var time_init_seg = Editor.steps_to_seconds(time_init_steps)
					
					note_select = %Line.add_note(pos_x, time_init_seg, Editor.steps_to_seconds(current_time_steps) )


func _on_v_slider_drag_ended(_value_changed: bool) -> void:
	drag = false

func _on_v_slider_drag_started() -> void:
	drag = true

func _on_v_slider_value_changed(value: float) -> void:
	if drag:
		Manager.current_time = Editor.steps_to_seconds(value)
		%AudioStreamPlayer.seek(Manager.current_time)

func _on_play_button_toggled(toggled_on: bool) -> void:
	if toggled_on: %AudioStreamPlayer.play(Manager.current_time)
	else: %AudioStreamPlayer.stop()
