extends CharacterBody2D
class_name Player

@export var SPEED = 300.0

@export var LEFT_ACTION = "LeftP1"
@export var RIGHT_ACTION = "RightP1"
@export var UP_ACTION = "UpP1"
@export var DOWN_ACTION = "DownP1"

@export var HEALTH_COMPONENT := Node2D
@export var PORTRAIT := Sprite2D

const OVERLAY = preload("res://Scenes/Interface/Overlay.tscn")

func health_changed(new,old):
	var shader_material = material as ShaderMaterial
	var portrait_shader_material = PORTRAIT.material as ShaderMaterial
	
	if new < old and new > 0:
		shader_material.set_shader_parameter("enabled",true)
		portrait_shader_material.set_shader_parameter("enabled",true)
		await get_tree().create_timer(.5).timeout
		shader_material.set_shader_parameter("enabled",false)
		portrait_shader_material.set_shader_parameter("enabled",false)
	elif new <= 0:
		shader_material.set_shader_parameter("enabled",false)
		portrait_shader_material.set_shader_parameter("enabled",false)
		
		var overlay = OVERLAY.instantiate()
		overlay.TEXT = "GAME OVER"
		overlay.TIME = 4
		get_parent().get_parent().get_child(1).add_child(overlay)
		
		await overlay.finish
		get_tree().call_deferred("reload_current_scene")
		
func handle_movement() -> void:
	# magija
	var dir = Input.get_vector(LEFT_ACTION,RIGHT_ACTION,UP_ACTION,DOWN_ACTION)
	velocity = dir * SPEED

func _ready():
	HEALTH_COMPONENT.health_changed.connect(health_changed)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(_delta: float) -> void:
	handle_movement()
	move_and_slide()
