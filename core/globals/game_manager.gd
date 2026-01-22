extends Node

var points: int = 0

var viewport_size_x: float

var current_time: float = 0

func _ready() -> void:
	viewport_size_x = get_viewport().get_visible_rect().size.x
