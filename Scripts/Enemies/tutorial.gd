extends "res://Scripts/Generic/GenericEnemy.gd"

var linija = preload("res://Scenes/Attacks/LineOfDeath.tscn")
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
	
func StartAttackLoop() -> void:
	$Label.text = "↑↓←→ / WASD za kretanje"
	$AttackTimer.start()
	await $AttackTimer.timeout
	$Label.text = "Laseri pokažu gde će ići"
	napad1()
	$AttackTimer.start()
	await $AttackTimer.timeout
	$Label.text = "Ne moraju biti horizontalni"
	napad2()
	$AttackTimer.start()
	await $AttackTimer.timeout
	$Label.text = "Brzo pretisni crvena slova"
	napad3()
	$AttackTimer.start()
	await $AttackTimer.timeout
	$SurviveTimer.start()
	while performed < 20:
		$Label.text = "Preživi: "+str(20-performed)
		attack()
		$AttackTimer.start(4-clamp(performed/3.0,0.1,3))
		await $AttackTimer.timeout
	$Label.text = "Sada nešto uradi, zaboravio sam da napravim :D"

func _ready():
	attacks.append(napad1)
	attacks.append(napad2)
	attacks.append(napad3)
	StartAttackLoop()
