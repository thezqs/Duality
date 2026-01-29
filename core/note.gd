extends Area2D 

class_name Note

enum TYPE {DARK, LIGHT}

var color = Color.TRANSPARENT:
	set(new):
		var tween = create_tween()
		
		tween.tween_property(self, "modulate", new, 1)
		await tween.finished
		
		color = new

var current_type: TYPE:
	set(new):
		current_type = new
		
		color = Color(new,new,new)
