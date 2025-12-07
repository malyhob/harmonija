extends "res://Scripts/Generic/GenericEnemy.gd"

#vasilijezivanovic2011@gmail.com
var linija = preload("res://Scenes/Attacks/LineOfDeath.tscn")
var cover = preload("res://Scenes/Attacks/cover.tscn")
var cover2 = preload("res://Scenes/Attacks/cover2.tscn")
var chain = preload("res://Scenes/Attacks/chain.tscn")

func napad1():
	var a = linija.instantiate()
	a.PLAYER = PLAYER
	a.global_position = Vector2(0,PLAYER.global_position.y)
	get_tree().current_scene.get_child(0).add_child.call_deferred(a)
	
func napad2():
	var a = linija.instantiate()
	a.PLAYER = PLAYER
	a.rotation = 90
	a.global_position = Vector2(PLAYER.global_position.x+130,0)
	get_tree().current_scene.get_child(0).add_child.call_deferred(a)
	
func napad3():
	var a = chain.instantiate()
	a.PLAYER = PLAYER
	a.global_position = PLAYER.global_position
	get_tree().current_scene.get_child(0).add_child.call_deferred(a)

func napad4():
	var a = cover.instantiate()
	a.PLAYER = PLAYER
	get_tree().current_scene.get_child(0).add_child.call_deferred(a)
func napad5():
	var a = cover2.instantiate()
	a.PLAYER = PLAYER
	get_tree().current_scene.get_child(0).add_child.call_deferred(a)
	
func StartAttackLoop() -> void:
	while true:
		attack()
		$AttackTimer.start(0.5)
		await $AttackTimer.timeout

func _ready():
	attacks.append(napad1)
	attacks.append(napad2)
	attacks.append(napad3)
	attacks.append(napad4)
	attacks.append(napad5)
	StartAttackLoop()
