extends CharacterBody2D
class_name Player

@export var SPEED = 300.0

@export var LEFT_ACTION = "LeftP1"
@export var RIGHT_ACTION = "RightP1"
@export var UP_ACTION = "UpP1"
@export var DOWN_ACTION = "DownP1"

@export var HEALTH_COMPONENT := Node2D

func health_changed(new,_old):
	if new <= 0:
		# promeni, hvala
		get_tree().call_deferred("reload_current_scene")

func handle_movement() -> void:
	# magija
	var dir = Input.get_vector(LEFT_ACTION,RIGHT_ACTION,UP_ACTION,DOWN_ACTION)
	velocity = dir * SPEED

func _ready():
	HEALTH_COMPONENT.health_changed.connect(health_changed)

func _physics_process(_delta: float) -> void:
	handle_movement()
	move_and_slide()
