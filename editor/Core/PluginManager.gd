extends Node

class_name PluginManager

## Define el root editor, nesesario para las funcion plugin_get_node.
@export var root_editor: RootEditor

const SETTINGS_WINDOW_PATH = "res://editor/plugins/SettingsWindows/SettingsWindow.tscn"

const LOOP_EDITOR_PATH = "res://editor/plugins/LoopEditor/LoopEditorMain.tscn"

## Variable que guarda los plugins actuales
var current_plugins: Dictionary = {}

#region

## Una funcion para ejecutar un plugin
func open_plugin(plugin_path: String):
	if current_plugins.has(plugin_path):
		Editor.editor_printerr(["Plugin ya abierto"])
		return
	
	var plugin_scene = load(plugin_path)
	
	if not plugin_scene is PackedScene:
		Editor.editor_printerr(["Archivo de escena invalido"])
		return
	
	var plugin_ins = plugin_scene.instantiate()
	
	if not plugin_ins is PluginWindow:
		Editor.editor_printerr(["La escena no contiene un plugin"])
		return
	
	plugin_ins = plugin_ins as PluginWindow
	
	add_child(plugin_ins)
	plugin_ins.plugin_popup(self)
	
	plugin_ins.close.connect( _plugin_close.bind(plugin_path) )
	
	current_plugins[plugin_path] = plugin_ins

## Se usa para cerrar un plugin de manera segura
func queue_close_plugin(plugin_path: String):
	if not current_plugins.has(plugin_path): return
	
	var plugin_ins: PluginWindow = current_plugins[plugin_path]
	
	plugin_ins.close_requested.emit()

#region aux plugin functions

## Una funcion para que los plugins puedan acceder al arbol de nodos (desde RootEditor).
func plugin_get_node(node_path: String) -> Node:
	var node = root_editor.get_node(node_path)
	
	if node == null: Editor.editor_printerr(["RootEditor.get_node(", node_path, ") -> null, continuando."])
	
	return node


## Una funcion para que los plugins puedan acceder al arbol de nodos (desde %Preview).
func plugin_get_node_in_preview(node_path: String):
	var node = %Preview.get_node(node_path)
	
	if node == null: Editor.editor_printerr(["$Preview.get_node(", node_path, ") -> null, continuando."])
	
	return node

## Una funcion para obtener el nodo %Preview de manera segura.
func get_preview_node() -> Node2D: return %Preview

#endregion

#region signal connect

## esta funcion esta conectada a una señal que se emite cuando se cierra la ventana.
func _plugin_close(plugin_path: String):
	var plugin_ins: PluginWindow = current_plugins[plugin_path]
	
	plugin_ins.close.disconnect(_plugin_close.bind(plugin_path))
	
	current_plugins.erase(plugin_path)

#endregion
