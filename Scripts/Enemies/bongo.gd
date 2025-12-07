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
	while performed < 6:
		$Dialog.dialog(str(6-performed),"")
		attack()
		$AttackTimer.start(3)
		await $AttackTimer.timeout
	$HealthComponent.damage(1)
	attacks.append(napad3)
	attacks.append(napad4)
	while performed < 15:
		$Dialog.dialog(str(15-performed),"")
		attack()
		$AttackTimer.start(4-performed/10.0)
		await $AttackTimer.timeout
	$Dialog.dialog("","")
	$HealthComponent.damage(1)
	$AudioStreamPlayer2D.stop()
	var overlay = OVERLAY.instantiate()
	overlay.TEXT = "Putuješ..."
	overlay.TIME = 3
	get_parent().get_parent().get_child(1).add_child(overlay)
	
	await overlay.finish
	get_tree().change_scene_to_file("res://Scenes/SCENES/didgeridoo.tscn")

func _ready():
	attacks.append(napad1)
	attacks.append(napad2)
	attacks.append(chain_attack)
	#attacks.append(napad3)
	#attacks.append(napad4)
	StartAttackLoop()
