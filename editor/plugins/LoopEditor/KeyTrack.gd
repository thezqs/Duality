extends Panel

## Un track de key frames para el [KeyTrackPanel]
class_name KeyTrack

var current_loop: AnimationLoop

func _init() -> void:
	custom_minimum_size.y = 50

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		pass

func _draw() -> void:
	pass
