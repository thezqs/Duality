extends Node
## Un script global especializado en hacer cualquier tipo de animacion

## Una funcion para animar un label como si fuera una maquina de escribir
func typewriter(label: Label, text: String, seg_per_letter: float = 0.05) -> void:
	label.text = text
	label.visible_characters = 0
	
	var duration = text.length() * seg_per_letter
	var tween_label = create_tween()
	
	tween_label.tween_property(label, "visible_characters", text.length(), duration)
	
	await  tween_label.finished
