extends HBoxContainer

func _on_loop_mode_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		%AnimationLoopPlayer.current_mode = AnimationLoopPlayer.MODE.LOOP

func _on_global_mode_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		%AnimationLoopPlayer.current_mode = AnimationLoopPlayer.MODE.GLOBAL

func _on_animation_loop_player_mode_changed(new_mode: AnimationLoopPlayer.MODE) -> void:
	%LoopModeButton.button_pressed = new_mode == AnimationLoopPlayer.MODE.LOOP
	%GlobalModeButton.button_pressed = new_mode == AnimationLoopPlayer.MODE.GLOBAL

func _on_play_button_toggled(toggled_on: bool) -> void:
	if toggled_on: %AudioStreamPlayer.play()
	else: %AudioStreamPlayer.stop()
