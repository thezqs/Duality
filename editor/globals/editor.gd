extends Node
## Un Script global que gestiona constantes, variables de el editor.
## Este Script global tambien tiene funciones auxiliares.

signal song_px_size_changed(new_size: float)

## Define los pixeles de espacio entre cada step
const PX_PER_STEP = 50

## Define los pixeles de radio de cada clave
const KEY_PX_SIZE = 10

var bpm = 150

## Variable que se usa para definir el hancho de la cancion en el editor.
var song_px_size: float = 0:
	set(new):
		song_px_size = new
		song_px_size_changed.emit(new)
