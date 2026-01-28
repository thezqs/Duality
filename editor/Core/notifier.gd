extends VBoxContainer

## Una clase que sirve para notificar 
## cualquier cosa de manera ordenada en un mensaje de notificacion
class_name Notifier

var popups: Array = []

func init_notificer(signal_to_connect: Signal, color: Color = Color.WHITE):
	signal_to_connect.connect(notice.bind(color) )

func notice(args, color: Color = Color.WHITE):
	var text = str(args)
	
	var label = Label.new()
	
	label.text = text
	
	label.modulate = Color.TRANSPARENT
	
	add_child(label)
	
	var tween = create_tween()
	
	tween.tween_property(label, "modulate", color, 0.5)
	
	await get_tree().create_timer(5).timeout
	
	if is_instance_valid(label):
		var tween_out = create_tween()
		tween_out.tween_property(label, "modulate", Color.TRANSPARENT, 1.0)
		tween_out.tween_callback(label.queue_free)
