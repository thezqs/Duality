extends Window

## Una clase especial para plugins de el editor.
class_name PluginWindow

## Se emite al cerrar la ventana.
signal close

## El plugin manager (nesesario para obtener las rutas de algunos nodos)
var plugin_manager: PluginManager

func _init():
	close_requested.connect(_close_requested)

## Funcion para abrir el plugin
func plugin_popup(manager: PluginManager):
	plugin_manager = manager
	
	popup_centered()

## Esta funcion puede ser modificada en clases ederadas
func _close_requested():
	close.emit()
	queue_free() ## Cerramos y ya
