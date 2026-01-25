extends PanelContainer

var plugins: Dictionary

func _ready() -> void:
	var plugins_paths = await Editor.get_plugins()
	
	var id: int = 0
	
	for path in plugins_paths:
		id += 1
		
		plugins[id] = path
		
		await get_tree().process_frame

func _on_plugins_item_list_item_activated(index: int) -> void:
	pass # Replace with function body.
