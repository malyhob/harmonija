extends CharacterBody2D

@export var PLAYER := CharacterBody2D
var dir

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $Timer.time_left > 2:
		dir = (PLAYER.global_position - global_position).normalized()
	velocity = dir*220
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		PLAYER.HEALTH_COMPONENT.damage(1)
		queue_free()


func _on_timer_timeout() -> void:
	call_deferred("queue_free")
