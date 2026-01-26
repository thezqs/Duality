extends Control

class_name RootEditor

func _ready() -> void:
	Editor.start_edit(SongResource.new())
	
	%Notifier.init_notificer(Editor.error, Color.RED)

func _on_settings_button_pressed() -> void:
	%PluginManager.open_plugin(%PluginManager.SETTINGS_WINDOW_PATH)

func _on_loop_editor_button_pressed() -> void:
	%PluginManager.open_plugin(%PluginManager.LOOP_EDITOR_PATH)


func _on_left_panel_button_toggled(toggled_on: bool) -> void:
	%LoopPanel.visible = toggled_on
