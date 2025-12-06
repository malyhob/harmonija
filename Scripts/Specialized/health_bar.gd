extends Control

const HEART_SCENE = preload("res://Scenes/Components/Heart.tscn")
@export var TRACK := CharacterBody2D

var hearts = []

func calculate_distance():
	var dist = 80
	for heart:Sprite2D in hearts:
		dist+=heart.global_scale.x + 80
	return dist

func add_heart():
	var heart = HEART_SCENE.instantiate()
	add_child(heart)
	
	heart.position = Vector2(calculate_distance(),0)
	hearts.append(heart)
	
func remove_heart():
	var heart:Sprite2D = hearts[hearts.size()-1]
	hearts.remove_at(hearts.find(heart))
	
	var tween = get_tree().create_tween()
	tween.tween_property(heart,"scale",Vector2(0,0),0.3)
	tween.tween_callback(heart.queue_free)
	
func health_changed(new,old):
	var dif = new-old
	var add = dif > 0
	
	for i in abs(dif):
		if add == true:
			add_heart()
		else:
			remove_heart()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var health_component = TRACK.HEALTH_COMPONENT
	
	for i in health_component.Health:
		add_heart()
	health_component.health_changed.connect(health_changed)
