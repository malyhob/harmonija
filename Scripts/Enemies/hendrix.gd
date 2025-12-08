extends "res://Scripts/Generic/GenericEnemy.gd"

var linija = preload("res://Scenes/Attacks/LineOfDeath.tscn")
var verti_linija = preload("res://Scenes/Attacks/LineOfDeath.tscn")
var bullet_direct = preload("res://Scenes/Attacks/bullet_direct.tscn")
var bullet_track = preload("res://Scenes/Attacks/bullet_track.tscn")
var chain = preload("res://Scenes/Attacks/chain.tscn")
var move_chain = preload("res://Scenes/Attacks/move_chain.tscn")

var cover1 = preload("res://Scenes/Attacks/cover.tscn")
var cover2 = preload("res://Scenes/Attacks/cover2.tscn")

var division = false

func div1():
	if not division:
		var a = cover1.instantiate()
		a.PLAYER = PLAYER
		get_tree().current_scene.get_child(0).add_child.call_deferred(a)
		
		division = true
		$SurviveTimer.start()
		await $SurviveTimer.timeout
		division = false
	
func div2():
	if not division:
		var a = cover2.instantiate()
		a.PLAYER = PLAYER
		get_tree().current_scene.get_child(0).add_child.call_deferred(a)
		
		division = true
		$SurviveTimer.start()
		await $SurviveTimer.timeout
		division = false
	
func chain_attack():
	var a = chain.instantiate()
	a.PLAYER = PLAYER
	a.global_position = PLAYER.global_position
	get_tree().current_scene.get_child(0).add_child.call_deferred(a)
	
func move_chain_attack():
	var a = move_chain.instantiate()
	a.PLAYER = PLAYER
	a.global_position = PLAYER.global_position
	get_tree().current_scene.get_child(0).add_child.call_deferred(a)
	
func bullet_rain():
	for _i in 2:
		var a = bullet_direct.instantiate()
		a.PLAYER = PLAYER
		a.global_position = Vector2(randi_range(0,960),0)
		get_tree().current_scene.get_child(0).add_child.call_deferred(a)
	
func napad1():
	print("linija")
	var a = linija.instantiate()
	a.PLAYER = PLAYER
	a.global_position = Vector2(0,PLAYER.global_position.y)
	get_tree().current_scene.get_child(0).add_child.call_deferred(a)
	
func StartAttackLoop() -> void:
	$Dialog.dialog("Hendrix","Good luck :3")
	$AttackTimer.start(3)
	await $AttackTimer.timeout
	while performed < 5:
		$Dialog.dialog(str(5-performed),"")
		attack()
		$AttackTimer.start(3)
		await $AttackTimer.timeout
	$HealthComponent.damage(1)
	while performed < 15:
		$Dialog.dialog(str(15-performed),"")
		attack()
		$AttackTimer.start(2.5)
		await $AttackTimer.timeout
	$HealthComponent.damage(1)
	while performed < 35:
		$Dialog.dialog(str(35-performed),"")
		attack()
		$AttackTimer.start(1.2)
		await $AttackTimer.timeout
	$HealthComponent.damage(1)
	$AudioStreamPlayer2D.stop()
	get_tree().change_scene_to_file("res://Scenes/SCENES/pobeda.tscn")

func _ready():
	attacks.append(chain_attack)
	attacks.append(move_chain_attack)
	attacks.append(bullet_rain)
	attacks.append(napad1)
	attacks.append(div1)
	attacks.append(div2)
	StartAttackLoop()
