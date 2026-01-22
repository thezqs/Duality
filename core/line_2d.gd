extends Line2D

class_name Line

## La escena de la nota.
const NOTE_SCENE = preload("res://core/note.tscn")

## Una variable que controla la duracion de la animacion de activar o desactivar la linea.
var animation_activate_time: float = 0.5

## Una variable de acceso a el nodo Aarea2D de el puntero
@onready var pointer: Area2D = $Pointer

## Una variable de acceso a el nodo Aarea2D de la linea
@onready var lostLine: Area2D = $LostLine

## Contiene las notas activas en el momento de la ejecucion
var current_notes: Dictionary = {}

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

## Una variable que controla el ancho horizontal de la linea.
var horizontal_width: float = 576.0:
	set(new):
		# actualizamos el ancho visual
		horizontal_width = new
		points[0].x = -new
		points[1].x = new
		
		# obtenemos la CollisionShape2D y la SegmentShape2D
		var colision: CollisionShape2D = lostLine.get_node("CollisionShape2D")
		var shape: SegmentShape2D = colision.shape
		
		# actualizamos la colicion para que coincida con lo que se ve
		shape.a.x = -new
		shape.b.x = new

func _physics_process(_delta: float) -> void:
	if is_activated:
		pointer.position.x = clamp(get_local_mouse_position().x, -horizontal_width, horizontal_width)
	
	var current_time: float = GameManager.current_time
	
	# NOTA: Uso la 'viewport_size_x' porque la linea rotara en el futuro. 
	# Y prefiero que haya espacio de sobra a que se vea como si las notas aparecen de la nada.
	var viewport_size_x: float = GameManager.viewport_size_x
	
	for note in current_notes.keys():
		note = note as Note
		
		var times = current_notes[note]
		var denominator = times.time_end - times.time_init
		
		# Evitamos división por cero por si acaso
		if denominator == 0: continue 
		
		var weight = (current_time - times.time_init) / denominator
		
		note.position.y = lerp(-viewport_size_x, 0, weight)

func add_note(pos_x: float, time_init: float, time_end: float):
	pos_x = clamp(pos_x, -horizontal_width, horizontal_width) 
	
	var note_ins = NOTE_SCENE.instantiate()
	note_ins.position.x = pos_x
	
	add_child(note_ins)
	
	current_notes[note_ins] = {"time_init" : time_init, "time_end" : time_end}

func _on_area_entered(area: Area2D, is_aciert: bool) -> void:
	if area == lostLine or not is_activated or area.is_in_group("Line"): return
	
	GameManager.points += int(is_aciert)
	
	area.queue_free()
	current_notes.erase(area)
