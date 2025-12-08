extends "res://Scripts/Generic/GenericEnemy.gd"

var cover1 = preload("res://Scenes/Attacks/cover.tscn")
var cover2 = preload("res://Scenes/Attacks/cover2.tscn")
var bullet_direct = preload("res://Scenes/Attacks/bullet_direct.tscn")
var bullet_track = preload("res://Scenes/Attacks/bullet_track.tscn")
var chain = preload("res://Scenes/Attacks/chain.tscn")

const OVERLAY = preload("res://Scenes/Interface/Overlay.tscn")
var division = false

func napad1():
	if not division:
		var a = cover1.instantiate()
		a.PLAYER = PLAYER
		get_tree().current_scene.get_child(0).add_child.call_deferred(a)
		
		division = true
		$SurviveTimer.start()
		await $SurviveTimer.timeout
		division = false
	
func napad2():
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
	
func napad3():
	var a = bullet_direct.instantiate()
	a.PLAYER = PLAYER
	a.global_position = Vector2(randi_range(0,960),600)
	get_tree().current_scene.get_child(0).add_child.call_deferred(a)
	
func napad4():
	var a = bullet_track.instantiate()
	a.PLAYER = PLAYER
	a.global_position = Vector2(randi_range(0,960),0)
	get_tree().current_scene.get_child(0).add_child.call_deferred(a)
	
func StartAttackLoop() -> void:
	$Dialog.dialog("","Pobedi da udjes u Agartu")
	while true:
		$Dialog.dialog(str(performed),"Pobedi da udjes u Agartu")
		attack()
		$AttackTimer.start(1)
		await $AttackTimer.timeout

func _ready():
	attacks.append(napad1)
	attacks.append(napad2)
	attacks.append(chain_attack)
	attacks.append(napad3)
	attacks.append(napad4)
	StartAttackLoop()
