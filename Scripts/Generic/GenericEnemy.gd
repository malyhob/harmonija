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

func StartAttackLoop() -> void:
	while true:
		attack()
		$AttackTimer.start()
		await $AttackTimer.timeout
