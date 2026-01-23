extends Node
## Un Script global que gestiona constantes, variables de el editor.
## Este Script global tambien tiene funciones auxiliares.

signal song_px_size_changed(new_size: float)

## Define los pixeles de espacio entre cada step
const PX_PER_STEP = 50

## Define los pixeles de radio de cada clave
const KEY_PX_SIZE = 10

## Define cuántos steps hay en un Beat
const STEPS_PER_BEAT = 16

## variable que define el modo editor
var editor_mode: bool = false

## Define el tiempo que tiene el jugador para ver la nota.
## O, en otras palabras, define la variable que se resta al tiempo actual 
## para definir el tiempo de aparicion de la nota.
## (Nota: Esta variable esta en steps, no en segundos)
var time_before_note: int = 16

## Una variable cache para obtener el bpm de la cancion en edicion actual
var bpm: float = 150.0

## Una variable cache para obtener los steps por segundo
var steps_per_second: float

## Variable que se usa para definir el ancho de la cancion en el editor.
var song_px_size: float = 0:
	set(new):
		song_px_size = new
		song_px_size_changed.emit(new)

var song_steps_size: int = 0

## Variable que define la cancion actual
var song_resource: SongResource 

## Variable de solo lectura para obtener el tiempo actual en steps
var current_time_steps: float = 0.0

## actualiza la variable cache steps_per_secon
func _update_conversion_cache() -> void:
	steps_per_second = (bpm / 60.0) * STEPS_PER_BEAT

## Actualiza la variable current_time_steps
func _current_time_changed(new_time):
	current_time_steps = seconds_to_steps(new_time)


## Iniciar el editor. (Esta funcion no habre la escena del editor)
func start_editing(song: SongResource):
	if not Manager.current_time_changed.is_connected(_current_time_changed):
		Manager.current_time_changed.connect(_current_time_changed)
	
	editor_mode = true
	
	song_resource = song
	
	var stream = song_resource.audio
	var stream_seconds = stream.get_length()
	
	@warning_ignore("integer_division")
	var stream_beats = stream_seconds * (bpm / 60)
	song_steps_size = stream_beats * STEPS_PER_BEAT
	song_px_size = song_steps_size * PX_PER_STEP
	
	_update_conversion_cache()

## Detener el editor. (Esta funcion no cierra la escena del editor)
func stop_editing():
	if Manager.current_time_changed.is_connected(_current_time_changed):
		Manager.current_time_changed.disconnect(_current_time_changed)
	
	editor_mode = false


## Convierte un tiempo en segundos a su equivalente en steps del editor.
func seconds_to_steps(seconds: float) -> float:
	if steps_per_second == 0: return 0.0
	return seconds * steps_per_second

## Convierte una cantidad de steps a tiempo en segundos.
func steps_to_seconds(steps: float) -> float:
	if steps_per_second == 0: return 0.0
	return steps / steps_per_second

## Función auxiliar para obtener la posición en píxeles basada en segundos
func seconds_to_px(seconds: float) -> float:
	return seconds_to_steps(seconds) * PX_PER_STEP
