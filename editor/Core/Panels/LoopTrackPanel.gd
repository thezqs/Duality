extends PanelContainer

class_name LoopTrackPanel

func add_track():
	%Tracks.add_child(LoopTrack.new())
	
	var track_icon = TrackIcon.new()
	%IconsTrack.add_child(track_icon)

func _on_add_track_button_pressed() -> void:
	add_track()
