extends Control

const MAIN_SCENE = preload("res://main.tscn")

@onready var notice_splash: PanelContainer = $notice

var ready_animation: bool = false

func _ready() -> void:
	$notice.visible = true
	$Splash.visible = true
	
	# ANIMACION DE ENTRADA -----------------------------------------------------
	
	var tween = create_tween()
	
	tween.tween_property($Splash/TextureRect, "modulate", Color.WHITE, 2)
	tween.tween_property($Splash/TextureRect, "modulate", Color.TRANSPARENT, 2)
	tween.tween_property($Splash, "modulate", Color.TRANSPARENT, 1)
	tween.tween_callback($Splash.queue_free)
	
	tween.tween_property($notice/Label, "modulate", Color.WHITE, 1)
	tween.tween_property($notice/Label, "modulate", Color.TRANSPARENT, 5)
	tween.tween_property(notice_splash, "modulate", Color.TRANSPARENT, 2)
	tween.tween_callback(notice_splash.queue_free)
	
	await tween.finished
	
	# FIN DE LA ANIMACION ------------------------------------------------------
	
	var text = ""
	
	if OS.has_feature("pc"):
		text += "Press Any Key"
	
	if DisplayServer.is_touchscreen_available():
		if text != "": text += " (Or Touch)"
		else: text += "Touch"
	
	text += " To Start"
	
	await Transitions.typewriter(%ToStartLabel, text)
	
	ready_animation = true

func _input(event: InputEvent) -> void:
	if not event is InputEventMouseMotion or not event is InputEventScreenDrag:
		if event.is_pressed():
			if notice_splash != null:
				var target = notice_splash
				notice_splash = null # usamos la referencia como flag
				# creamos un mini fade out para evitar que se sienta brusco
				var tween = create_tween()
				tween.tween_property(target, "modulate", Color.TRANSPARENT, 1)
				tween.tween_callback(target.hide)
				
				tween.tween_callback(target.queue_free) # ya no te nesesitamos, fuiste un buen soldado... XD
				return
			
			if ready_animation:
				ready_animation = false
				pass
