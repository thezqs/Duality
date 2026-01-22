extends Node

## Puntos de la partida
var points: int = 0

## tamaño del viewport
var viewport_size_x: float

## Tiempo actual de la cancion
var current_time: float = 0

func _ready() -> void:
	viewport_size_x = get_viewport().get_visible_rect().size.x
