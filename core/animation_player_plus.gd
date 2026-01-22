extends AnimationPlayer

## Un nodo AnimationPlayer Mejorado para poder crear, editar o reproducir animaciones desde codigo.
class_name AnimationPlayerPlus

## La animacion cargada actualmente.
var animation: AnimationLoop
## La libreria de animacion global.
var global_library: AnimationLibrary

## Tiempo Global actual de la animacion.
var global_time: float = 0.0 

## Bandera de reproduccion de animacion. 
## Se recomienda reproducir o pausar la animacion desde las funciones animation_play y animation_pause.
var is_animation_playing: bool = false

func _ready() -> void:
	global_library = AnimationLibrary.new()
	add_animation_library("Global", global_library)

func _process(_delta: float) -> void:
	if not is_animation_playing:
		seek(global_time)
	elif not is_playing() and not is_animation_playing:
		play("preview")
		seek(global_time)

## Funcion para reproducir la animacion actual.
func animation_play():
	is_animation_playing = true

## Funcion para pausar la animacion actual.
func animation_pause():
	is_animation_playing = false

#region Load, Create & Remove Animations

## Funcion para crear una animacion.
func create_animation():
	if not global_library.has_animation("preview"):
		animation = AnimationLoop.new()
		global_library.add_animation("preview", animation)
		play("Global/preview")

## Funcion para cargar una animacion.
func load_animation(anim: Animation):
	if not global_library.has_animation("preview"):
		animation = anim
		global_library.add_animation("preview", animation)
		play("Global/preview")

## Funcion para remover una animacion.
## La vista previa se pausara hasta agregar una nueva.
func remove_animation():
	if global_library.has_animation("preview"):
		stop()
		global_library.remove_animation("preview")
		animation = null

#endregion

#region Edit

## Funcion para insertar una clave de animacion.
func insert_animation_key(track_index: int, time: float, key):
	animation.track_insert_key(track_index, time, key)

## Funcion para agregar un track de animacion.
func add_anim_track(node_path: String, variant: String, animation_type: Animation.TrackType) -> int:
	var track_index = animation.add_track(animation_type)
	animation.track_set_path(track_index, node_path + ":" + variant)
	
	return track_index

## Funcion para redimencionar una animacion.
func rezise_animation(value: float):
	animation.length = value

#endregion
