extends PanelContainer

## Un panel que contiene todos los tracks actualmente usados.
class_name TrackPanel

func _on_animation_loop_player_mode_changed(new_mode: AnimationLoopPlayer.MODE) -> void:
	$ContainerModeLoop.visible = new_mode == AnimationLoopPlayer.MODE.LOOP
	#$ContainerModeGlobal.visible = new_mode == AnimationLoopPlayer.MODE.GLOBAL
