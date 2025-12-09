extends "res://Scripts/Generic/GenericEnemy.gd"

var laser1 = preload("res://Scenes/Attacks/VerticalLOD.tscn")
var bullet_direct = preload("res://Scenes/Attacks/bullet_direct.tscn")
var bullet_track = preload("res://Scenes/Attacks/bullet_track.tscn")
var chain = preload("res://Scenes/Attacks/chain.tscn")
var move_chain = preload("res://Scenes/Attacks/move_chain.tscn")

const OVERLAY = preload("res://Scenes/Interface/Overlay.tscn")
	
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
	
func bullet_hell():
	var a = bullet_track.instantiate()
	a.PLAYER = PLAYER
	a.global_position = Vector2(randi_range(0,960),600)
	get_tree().current_scene.get_child(0).add_child.call_deferred(a)
	
func laseri_levo():
	for i in 4:
		var a = laser1.instantiate()
		a.PLAYER = PLAYER
		a.global_position = Vector2(randi_range(10,450),0)
		get_tree().current_scene.get_child(0).add_child.call_deferred(a)

func laseri_desno():
	for i in 4:
		var a = laser1.instantiate()
		a.PLAYER = PLAYER
		a.global_position = Vector2(randi_range(450,950),0)
		get_tree().current_scene.get_child(0).add_child.call_deferred(a)
	
func StartAttackLoop() -> void:
	attacks.append(laseri_levo)
	attacks.append(laseri_desno)
	while performed < 5:
		$Dialog.dialog(str(5-performed),"")
		attack()
		$AttackTimer.start(2)
		await $AttackTimer.timeout
	$HealthComponent.damage(1)
	attacks.clear()
	attacks.append(bullet_rain)
	attacks.append(chain_attack)
	attacks.append(move_chain_attack)
	while performed < 10:
		$Dialog.dialog(str(10-performed),"")
		attack()
		$AttackTimer.start(2)
		await $AttackTimer.timeout
	attacks.append(bullet_hell)
	attacks.append(laseri_levo)
	attacks.append(laseri_desno)
	attacks.append(move_chain_attack)
	while performed < 20:
		$Dialog.dialog(str(20-performed),"")
		attack()
		$AttackTimer.start(2)
		await $AttackTimer.timeout
	$HealthComponent.damage(1)
	$AudioStreamPlayer2D.stop()
	var overlay = OVERLAY.instantiate()
	overlay.TEXT = tr("TRAVEL")
	overlay.TIME = 3
	get_parent().get_parent().get_child(1).add_child(overlay)
	
	await overlay.finish
	get_tree().change_scene_to_file("res://Scenes/SCENES/hendrix.tscn")

func _ready():
	StartAttackLoop()
