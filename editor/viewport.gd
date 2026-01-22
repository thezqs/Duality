extends Node2D

@onready var mouse_pointer = $Mouse

func _process(_delta: float) -> void:
	mouse_pointer.position = (get_viewport().get_mouse_position() - Vector2(288, 162)) * 2
