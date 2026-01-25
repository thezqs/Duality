extends Window

class_name PluginWindow

var plugin_manager: PluginManager

func _init():
	close_requested.connect(_close_requested)

func plugin_popup(manager: PluginManager):
	plugin_manager = manager
	
	popup_centered()

## Esta funcion sera modificada en clases ederadas
func _close_requested():
	queue_free() ## Cerramos y ya
