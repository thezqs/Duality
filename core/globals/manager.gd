extends Node

signal current_time_changed(new_current_time: float)

## Puntos de la partida
var points: int = 0

## tamaño del viewport
var viewport_size_x: float

## Tiempo actual de la cancion
var current_time: float = 0:
	set(new):
		## queremos que todo se ejecute si algo de verdad ha cambiado.
		if current_time != new:
			current_time = new
			current_time_changed.emit(new)

func _ready() -> void:
	viewport_size_x = get_viewport().get_visible_rect().size.x
