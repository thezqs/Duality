extends PanelContainer

class_name TrackIcon

var texture_rect: TextureRect

func set_icon(new_icon: Texture2D):
	texture_rect.texture = new_icon

func _init() -> void:
	custom_minimum_size.y = 50
	custom_minimum_size.x = 50
	
	texture_rect = TextureRect.new()
	
	texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	add_child(texture_rect)
