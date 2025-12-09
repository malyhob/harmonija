extends Control

func _input(event):
	if event.is_action_pressed("Quit"):
		get_tree().quit()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var lang = TranslationServer.get_locale()
	print(lang)
	if lang == "en_US": $Sprite2D.texture = load("res://Assets/Background/endscreen_en.png")
	
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate",Color(1,1,1,1),1)
	tween.tween_callback($AudioStreamPlayer2D.play)
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/SCENES/menu.tscn")
