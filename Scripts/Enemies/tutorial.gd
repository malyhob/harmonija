extends "res://Scripts/Generic/GenericEnemy.gd"

var linija = preload("res://Scenes/Attacks/LineOfDeath.tscn")
var chain = preload("res://Scenes/Attacks/chain.tscn")

const OVERLAY = preload("res://Scenes/Interface/Overlay.tscn")

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
	
func StartAttackLoop() -> void:
	$Dialog.dialog("TUTORIAL",tr("TUT1"))
	$AttackTimer.start()
	await $AttackTimer.timeout
	$Dialog.dialog("TUTORIAL",tr("TUT2"))
	napad1()
	$AttackTimer.start()
	await $AttackTimer.timeout
	$Dialog.dialog("TUTORIAL",tr("TUT3"))
	napad2()
	$AttackTimer.start()
	await $AttackTimer.timeout
	$Dialog.dialog("TUTORIAL",tr("TUT4"))
	napad3()
	$AttackTimer.start()
	await $AttackTimer.timeout
	while performed < 20:
		$Dialog.dialog("TUTORIAL",tr("TUT5")+str(20-performed))
		attack()
		$AttackTimer.start(4-clamp(performed/3.0,0.1,3))
		await $AttackTimer.timeout
	$AudioStreamPlayer2D.stop()
	var overlay = OVERLAY.instantiate()
	overlay.TEXT = tr("TRAVEL")
	overlay.TIME = 3
	get_parent().get_parent().get_child(1).add_child(overlay)
	
	await overlay.finish
	get_tree().change_scene_to_file("res://Scenes/SCENES/bongo.tscn")
	
func _ready():
	attacks.append(napad1)
	attacks.append(napad2)
	attacks.append(napad3)
	StartAttackLoop()
