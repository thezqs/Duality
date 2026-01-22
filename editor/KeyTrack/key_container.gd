extends Control

## Una clase hecha para visualizar, modificar y borrar claves de animacion.
class_name KeyContainer

## Diccionario utilizado para guardar las claves.
var keys: Dictionary = {}:
	set(new):
		keys = new
func _ready() -> void:
	gui_input.connect(_gui_input)

func _draw() -> void:
	for key in keys.keys():
		draw_circle(Vector2(key * Editor.PX_PER_STEP, 25 ), Editor.KEY_PX_SIZE, Color.WHITE)

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.is_pressed():
			var position_key: int = -1
			
			# parte a refactorizar -------------------------------
			
			var event_position_x = event.position.x / Editor.PX_PER_STEP
			var center = int(event_position_x) + 0.5
			
			if event_position_x > center:
				position_key = int(event_position_x) + 1
			else:
				position_key = int(event_position_x)
			
			# ---------------------------------------------------
			if event.button_index == MOUSE_BUTTON_LEFT:
				keys[position_key] = Vector2.ZERO
			elif event.button_index == MOUSE_BUTTON_RIGHT:
				keys.erase(position_key)
#			
			queue_redraw() # re-dibujamos para que la parte visual se actualize.
