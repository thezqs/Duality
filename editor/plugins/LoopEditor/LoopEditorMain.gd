extends PluginWindow

## Un plugin para crear y editar loops.
class_name LoopEditor

var current_loop: AnimationLoop

func _ready() -> void:
	var buttom_popup: Popup = %SelectPreviewButton.get_popup()
	buttom_popup.transparent_bg = true
	
	%ConfirmationDialog.add_button("Exit And Save", true, "exit_and_save")
	
	%KeyTrackPanel.init_tracks(current_loop)

func _close_requested(is_exit: bool = false):
	if is_exit:
		close.emit()
		
		var tween = create_tween()
		
		tween.tween_property(self,"size:y", 0 , 0.1)
		
		tween.tween_callback(queue_free)
	else:
		# Esperamos un frame para que tenga el foco la nueva ventana.
		await get_tree().process_frame
		
		%ConfirmationDialog.popup_centered()

#region Confirmation Dialog

func _on_confirmation_dialog_canceled() -> void:
	%ConfirmationDialog.hide()

func _on_confirmation_dialog_confirmed() -> void:
	%ConfirmationDialog.hide()
	_close_requested(true)

func _on_confirmation_dialog_custom_action(action: StringName) -> void:
	if action == "exit_and_save":
		%ConfirmationDialog.hide()
		
		save()
		
		await get_tree().process_frame
		
		_close_requested(true)

#endregion

#region señales de botones 

func _on_play_button_toggled(toggled_on: bool) -> void:
	if toggled_on: %AnimationPlayerPlus.animation_play()
	else: %AnimationPlayerPlus.animation_pause()

func _on_save_button_pressed() -> void:
	save()

#endregion

#region funciones auxiliares

func save():
	Editor.editor_printerr(["No se ha podido completar la accion."])

#endregion
