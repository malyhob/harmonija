extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate",Color(1,1,1,1),1)
	tween.tween_callback($AudioStreamPlayer2D.play)
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/SCENES/menu.tscn")
