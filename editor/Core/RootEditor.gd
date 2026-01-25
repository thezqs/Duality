extends Control

class_name RootEditor

func _ready() -> void:
	Editor.start_edit(SongResource.new())

func _on_loops_libary_button_toggled(toggled_on: bool) -> void:
	%LoopPanel.visible = toggled_on

func _on_settings_button_pressed() -> void:
	%PluginManager.exec_plugin(%PluginManager.SETTINGS_WINDOW_PATH)
