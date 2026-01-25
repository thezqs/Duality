extends AnimationPlayerPlus

## Un nodo encargado de editar, reproducir y compilar AnimationLoops.
class_name AnimationLoopPlayer

#region signals

## Se emite cuando el modo es cambiado
signal mode_changed(new_mode: MODE)

## Se emite cuando la compilacion de la animacion ha finalizado
signal compile_finish(no_error: bool)

## Se emite cuando el loop seleccionado cambia
signal loop_select_changed(new_select: AnimationLoop)

## se emite cuando la secuencia de loops cambia
signal loop_sequence_changed(new_loop_sequence: Array[Array])

## se emite cuando la libreria de loops cambia
signal loops_libary_changed(new_loops_libary: Dictionary)

#endregion

## Una enumeracion de los modos.
enum MODE {LOOP, GLOBAL}

#region variables

## Modo actual de edicion o reproduccion.
var current_mode: MODE = MODE.LOOP:
	set = _set_mode

## Todos los loops contenidos.
## [b]Nota:[/b] Los loops se guardan [clave/int] : [loop/AnimationLoop].
var loops_libary: Dictionary = {}:
	set = set_loops_libary

## La secuencia de loops 
var loop_sequence: Array[Array] = []:
	set = _set_loops_sequence

## Una variable de referencia a el loop seleccionado actualmente.
var animation_loop_select: AnimationLoop:
	set = _set_animation_loop_select

## Una Variable para saber si se esta compilando una animacion o no.
var is_compile: bool = false:
	set = _set_is_compile

#endregion

 #region setters

func _set_mode(new_mode: MODE):
	if current_mode == new_mode: 
		printerr(" El modo actual es igual al modo a cambiar. Omitiendo..")
		return
	
	current_mode = new_mode
	
	if is_compile: 
		printerr(" Compilando aun la animacion. Porfavor espere...")
		await compile_finish
	
	match current_mode:
		MODE.LOOP:
			animation = animation_loop_select
		MODE.GLOBAL:
			animation = await compile_animation()
	
	mode_changed.emit(current_mode)

func _set_is_compile(new_bool: bool):
	is_compile = new_bool
	compile_finish.emit(new_bool)

func _set_animation_loop_select(new_select: AnimationLoop):
	animation_loop_select = new_select
	loop_select_changed.emit(new_select)

func _set_loops_sequence(new_loop_sequence: Array[Array]):
	loop_sequence = new_loop_sequence
	loop_sequence_changed.emit(new_loop_sequence)

func set_loops_libary(new_loops_libary: Dictionary):
	loops_libary = new_loops_libary
	loops_libary_changed.emit(new_loops_libary)

#endregion

## Una funcion para compilar la animacion
func compile_animation() -> AnimationLoop:
	var animation_compiled: AnimationLoop = AnimationLoop.new() 
	
	is_compile = true # avisamos que estamos compilando.
	
	for loop_track in loop_sequence:
		loop_track = loop_track as Array
		
		for loop_id in loop_track:
			loop_id = loop_id as int
			
			var loop: AnimationLoop = loops_libary.get(loop_id)
			
			if loop == null: 
				printerr(" No Se encontro el loop ", loop_id, " retornando la animacion")
				is_compile = false
				
				# retornamos la animacion ahora ya que lo demas tampoco se encontraran
				return animation_compiled
			
			for track_id in range(loop.get_track_count()):
				track_id = track_id as int
				
				var track_type = loop.track_get_type(track_id)
				
				var compile_animation_track_id = animation_compiled.add_track(track_type)
				
				for key_id in loop.track_get_key_count(track_id):
					var key_time = loop.track_get_key_time(track_id, key_id)
					var key = loop.track_get_key_value(track_id, key_id)
					
					animation_compiled.track_insert_key(compile_animation_track_id, \
					loop.time_init + key_time, key)
			
			# Nota: Se que este await realentiza todo el juego.
			# Luego optimizo esta parte para que suseda de vez en cuando.
			# Pero por ahora, solo:
			await get_tree().process_frame
	
	is_compile = false
	return animation_compiled

## Una funcion para obtener todas las claves de animacion de un track en el loop actual.
func get_anim_loop_keys(track_id: int) -> Dictionary:
	var keys: Dictionary = {}
	
	for key in range(animation_loop_select.track_get_key_count(track_id)):
		key = key as int
		
		# obtenemos el valor de la calve
		var value = animation_loop_select.track_get_key_value(track_id, key)
		
		# y guardamos la clave en el diccionario
		keys[animation_loop_select.track_get_key_time(track_id, key)] = value
	
	return keys # retorna todas las claves que se encontraron
