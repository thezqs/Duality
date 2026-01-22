extends Area2D

class_name Note

enum TYPE {DARK, LIGHT}

var current_type: TYPE:
	set(new):
		current_type = new
		modulate = Color(new,new,new)
