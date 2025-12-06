extends Area2D

@export var PLAYER := CharacterBody2D

var in_area = false

func _ready() -> void:
	$Line2D.default_color = Color(255, 0.0, 0.0, 0.15)
	var tween = get_tree().create_tween()
	tween.tween_property($Line2D,"default_color",Color(255, 0.0, 0.0, 0.3),0.3)
	tween.tween_property($Line2D,"default_color",Color(255, 0.0, 0.0, 0.15),0.3)
	$Timer.start()

func _on_timer_timeout() -> void:
	$Line2D.default_color = Color(255,0,0,1)
	if in_area:
		PLAYER.HEALTH_COMPONENT.damage(1)
	$Timer.start(0.1)
	await $Timer.timeout
	$Line2D.default_color = Color(255, 0.0, 0.0, 0.1)
	queue_free()
	
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		in_area = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		in_area = false
