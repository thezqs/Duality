extends PluginWindow

func _ready() -> void:
	var buttom_popup: Popup = %SelectPreviewButton.get_popup()
	buttom_popup.transparent_bg = true

func _close_requested():
	close.emit()
	queue_free()

#region Señales conectadas

func _on_play_button_toggled(toggled_on: bool) -> void:
	if toggled_on: %AnimationPlayerPlus.animation_play()
	else: %AnimationPlayerPlus.animation_pause()

func _on_save_button_pressed() -> void:
	Editor.editor_printerr(["No se ha podido completar la accion."])
