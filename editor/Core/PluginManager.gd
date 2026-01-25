extends Node

class_name PluginManager

## Define el root editor, nesesario para las funcion plugin_get_node.
@export var root_editor: RootEditor

const SETTINGS_WINDOW_PATH = "res://editor/plugins/SettingsWindows/SettingsWindow.tscn"

## Una funcion para ejecutar un plugin
func exec_plugin(plugin_path: String):
	var plugin_scene = load(plugin_path)
	
	if not plugin_scene is PackedScene:
		printerr(" Archivo de escena invalido")
		return
	
	var plugin_ins = plugin_scene.instantiate()
	
	if not plugin_ins is PluginWindow:
		printerr(" La escena no contiene un plugin")
		return
	
	plugin_ins = plugin_ins as PluginWindow
	
	add_child(plugin_ins)
	plugin_ins.plugin_popup(self)

## Una funcion para que los plugins puedan acceder al arbol de nodos (desde RootEditor).
func plugin_get_node(node_path: String) -> Node:
	var node = root_editor.get_node(node_path)
	
	if node == null: printerr(" RootEditor.get_node(", node_path, ") -> null, continuando.")
	
	return node


## Una funcion para que los plugins puedan acceder al arbol de nodos (desde %Preview).
func plugin_get_node_in_preview(node_path: String):
	var node = %Preview.get_node(node_path)
	
	if node == null: printerr(" $Preview.get_node(", node_path, ") -> null, continuando.")
	
	return node

## Una funcion para obtener el nodo %Preview de manera segura.
func get_preview_node() -> Node2D: return %Preview
