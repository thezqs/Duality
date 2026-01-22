extends Line2D

class_name Line

## Una variable que controla la duracion de la animacion de activar o desactivar la linea.
var animation_activate_time: float = 0.5

## Una variable de acceso a el nodo Aarea2D de el puntero
@onready var pointer: Area2D = $Pointer

## Una variable de acceso a el nodo Aarea2D de la linea
@onready var lostLine: Area2D = $LostLine

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
		
		if new:
			pointer.visible = new
			
			tween.tween_property(pointer, "modulate", Color(1,1,1,1), animation_activate_time)
			
		else:
			tween.tween_property(pointer, "modulate", Color(1,1,1,0), animation_activate_time)
			
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

func _on_area_entered(area: Area2D, is_aciert: bool) -> void:
	if area == lostLine or not is_activated or area.is_in_group("Line"): return
	
	GameManager.points += int(is_aciert)
	 
	print(int(is_aciert))
