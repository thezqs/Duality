extends PluginWindow

## Funcion para abrir el plugin
func plugin_popup(manager: PluginManager):
	plugin_manager = manager
	
	popup_centered()

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

#endregion
