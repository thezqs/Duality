extends TabContainer

var plugins: Array

var is_load: bool = true

var search_count: int = 0

@export var plugin_manager: PluginManager

func _ready() -> void:
	%PluginsItemList.allow_search = true
	
	var plugins_paths: Array = await Editor.get_plugins("res://editor/plugins/")
	
	plugins_paths.append_array(await Editor.get_plugins())
	
	plugins = plugins_paths
	
	is_load = false
	
	for path in plugins_paths:
		var plugin_item: String = path.get_file().get_basename()
		
		var plugin_name = plugin_item.replace("Main", "")
		
		%PluginsItemList.add_item(plugin_name)
		
		await get_tree().process_frame

## Se usa solo para la animacion de carga
func _process(delta: float) -> void:
	if is_load:
		$Plugins/LoadPlugin.rotation += delta * 5
	else: 
		$Plugins/LoadPlugin.visible = false
		set_process(false)

func _on_plugins_item_list_item_activated(index: int) -> void:
	if is_instance_valid(plugin_manager):
		plugin_manager.open_plugin(plugins[index])
	else: printerr("plugin_manager = null")

func _on_search_plugins_line_edit_text_changed(new_text: String) -> void:
	search_count += 1
	var current_search_id = search_count
	
	%PluginsItemList.clear()
	
	for path in plugins:
		# Si el ID cambió, significa que el usuario escribió otra cosa
		# y este bucle debe morir para no estorbar al nuevo.
		if current_search_id != search_count: 
			return 
			
		var plugin_name = path.get_file().get_basename().replace("Main", "")
		
		if new_text == "" or new_text.to_lower() in plugin_name.to_lower():
			%PluginsItemList.add_item(plugin_name)
			await get_tree().process_frame
