extends PanelContainer

class_name KeyTrackPanel

@export var select_property: SelectPropertyPanel

var current_loop: AnimationLoop = null

func init_tracks(loop: AnimationLoop):
	current_loop = loop

func _on_add_track_button_pressed() -> void:
	select_property.up(Line.new())
	
	var key_track: KeyTrack = KeyTrack.new()
	
	key_track.current_loop = current_loop
	
	%Tracks.add_child(key_track)
	
	var track_icon = TrackIcon.new()
	%IconsTrack.add_child(track_icon)
