extends Node2D

@export var PLAYER := CharacterBody2D
@export var HEALTH_COMPONENT := Node2D

var attacks:Array[Callable] = []
var performed = 0

func attack():
	# prosiri <3
	if attacks.size() <= 0:
		return
	
	performed+=1
	attacks.pick_random().call()

func health_changed(new,old):
	var shader_material = material as ShaderMaterial
	if new < old:
		shader_material.set_shader_parameter("enabled",true)
		await get_tree().create_timer(.5).timeout
		shader_material.set_shader_parameter("enabled",false)

func StartAttackLoop() -> void:
	HEALTH_COMPONENT.health_changed.connect(health_changed)
	while true:
		attack()
		$AttackTimer.start()
		await $AttackTimer.timeout
		
