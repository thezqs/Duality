extends Control

func _ready() -> void:
	$ColorRect.visible = true
	var tween = create_tween()
	tween.tween_property($ColorRect, "color", Color(0,0,0,0), 1)
