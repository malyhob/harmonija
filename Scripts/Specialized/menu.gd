extends Node2D

func _ready():
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
