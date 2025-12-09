extends Node2D

func _change_lang(id):
	var lang = "en_US"
	match id:
		0: lang = "en_US"
		1: lang = "rs"
	
	TranslationServer.set_locale(lang)
	$LanguageSelector.text = "lang: "+lang
	
func _input(event):
	if event.is_action_pressed("Quit"):
		get_tree().quit()

func _ready():
	get_tree().set_meta("lang","en")
	$LanguageSelector.get_popup().id_pressed.connect(_change_lang)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	$AnimatedSprite2D.play()
	await $AnimatedSprite2D.animation_looped
	$AudioStreamPlayer2D.play()
	$AnimatedSprite2D.pause()
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D,"modulate",Color(1,1,1,0),0.6)
	tween.tween_callback($AnimatedSprite2D.queue_free)
	

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/SCENES/tutorial.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/SCENES/endless.tscn")
