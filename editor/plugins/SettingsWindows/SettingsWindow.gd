extends PluginWindow

class_name SettingsWindow

#region General

func _on_song_name_line_edit_text_changed(new_text: String) -> void:
	Editor.song.song_name = new_text

func _on_artist_name_line_edit_text_changed(new_text: String) -> void:
	Editor.song.artist_name = new_text

func _on_charter_name_line_edit_text_changed(new_text: String) -> void:
	Editor.song.chart_of = new_text

#endregion
