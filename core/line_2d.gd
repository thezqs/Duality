extends Line2D

## La linea tipica de el juego.
class_name Line

## Define el ncho por defecto de la linea
const WIDTH: float = 576.0

## La escena de la nota.
const NOTE_SCENE: PackedScene = preload("res://core/note.tscn")

## Una variable que controla la duracion de la animacion de activar o desactivar la linea.
var animation_activate_time: float = 0.5

## Una variable de acceso a el nodo Aarea2D de el puntero
@onready var pointer: Area2D = $Pointer

## Una variable de acceso a el nodo Aarea2D de la linea
@onready var lostLine: Area2D = $LostLine

## Contiene las notas activas en el momento de la ejecucion
var current_notes: Dictionary = {}

## Una variable de solo lectura para obtener el ancho actual de la linea
var current_horizontal_size: float = 576.0

## Una variable que controla si la linea esta activada o apagada.
var is_activated: bool = false:
	set(new):
		 # Queremos que solo se ejecute esto si algo ha cambiado de verdad.
		if is_activated == new: return
		
		is_activated = new
		
		# si esta desactivado, las coliciones se desactivan.
		pointer.get_node("CollisionShape2D").disabled = not new
		lostLine.get_node("CollisionShape2D").disabled = not new
		
		var tween = create_tween()
		
		tween.tween_property(pointer, "modulate", Color(1,1,1,int(new)), animation_activate_time)
		
		if new:
			pointer.visible = new
		else:
			# esperamos a que se desvanesca para cambiar visible a false
			await tween.finished
			pointer.visible = new

## Un multiplicador que controla el ancho horizontal de la linea.
var width_multiplicer: float = 1:
	set(new):
		width_multiplicer = clamp(new, 0, 1)
		
		# actualizamos el ancho visual
		var horizontal_size: float = WIDTH * width_multiplicer
		
		points[0].x = -horizontal_size
		points[1].x = horizontal_size
		
		# obtenemos la CollisionShape2D y la SegmentShape2D
		var colision: CollisionShape2D = lostLine.get_node("CollisionShape2D")
		var shape: SegmentShape2D = colision.shape
		
		# actualizamos la colicion para que coincida con lo que se ve
		shape.a.x = -horizontal_size
		shape.b.x = horizontal_size
		
		current_horizontal_size = horizontal_size

func _physics_process(_delta: float) -> void:
	if is_activated:
		pointer.position.x = clamp(get_local_mouse_position().x, -current_horizontal_size, current_horizontal_size)
	
	var current_time: float = Manager.current_time
	
	# NOTA: Uso la 'viewport_size_x' porque la linea rotara en el futuro. 
	# Y prefiero que haya espacio de sobra a que se vea como si las notas aparecen de la nada.
	var viewport_size_x: float = Manager.viewport_size_x
	
	for note in current_notes.keys():
		note = note as Note
		
		var times = current_notes[note]
		
		var denominator = times.time_end - times.time_init
		
		# Evitamos división por cero por si acaso
		if denominator == 0: continue 
		
		var weight = (current_time - times.time_init) / denominator
		
		note.position.y = lerp(-viewport_size_x, 0.0, weight)
		note.position.x = times.orig_x * width_multiplicer

func _on_area_entered(area: Area2D, is_aciert: bool) -> void:
	if area == lostLine or not is_activated or area.is_in_group("Line"): return
	
	Manager.points += int(is_aciert)
	
	if Editor.editor_mode: return
	
	area.queue_free()
	current_notes.erase(area)


## Añade una nota y retorna la nota añadida
func add_note(pos_x: float, time_init: float, time_end: float, type: Note.TYPE = Note.TYPE.LIGHT) -> Note:
	var note_ins = NOTE_SCENE.instantiate()
	
	pos_x = clamp(pos_x, -WIDTH, WIDTH)
	
	note_ins.position.x = pos_x * width_multiplicer
	
	add_child(note_ins)
	
	note_ins.current_type = type
	
	current_notes[note_ins] = {"time_init" : time_init, "time_end" : time_end, "orig_x" : pos_x}
	
	return note_ins

func remove_note(note: Note):
	if is_instance_valid(note):
		note.queue_free()
		current_notes.erase(note)
