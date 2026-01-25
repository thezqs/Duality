extends PluginWindow

class_name SettingsWindow

func _ready() -> void:
	%SongNameLineEdit.text = Editor.song.song_name
	%ArtistNameLineEdit.text = Editor.song.artist_name 
	%CharterNameLineEdit.text = Editor.song.chart_of

#region General

func _on_song_name_line_edit_text_changed(new_text: String) -> void:
	Editor.song.song_name = new_text

func _on_artist_name_line_edit_text_changed(new_text: String) -> void:
	Editor.song.artist_name = new_text

func _on_charter_name_line_edit_text_changed(new_text: String) -> void:
	Editor.song.chart_of = new_text

#endregion

func _close_requested():
	Editor.settings.save_settings()
	
	close.emit()
	
	queue_free()
