extends VBoxContainer

## Una clase que sirve para notificar 
## cualquier cosa de manera ordenada en un mensaje de notificacion
class_name Notifier

func init_notificer(signal_to_connect: Signal):
	signal_to_connect.connect(notice)

func notice(arg):
	var text = str(arg)
	
	var label = Label.new()
	
	label.text = text
	
	label.modulate = Color.TRANSPARENT
	
	add_child(label)
	
	var tween = create_tween()
	
	tween.tween_property(label, "modulate", Color.WHITE, 0.5)
	
	await get_tree().create_timer(5).timeout
	
	if is_instance_valid(label):
		var tween_out = create_tween()
		tween_out.tween_property(label, "modulate", Color.TRANSPARENT, 1.0)
		tween_out.tween_callback(label.queue_free)
