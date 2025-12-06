extends Node2D
class_name HealthComponent

signal health_changed(new,old)

@export var MAX_HEALTH:int
var Health:int
var LastHurt:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Health = MAX_HEALTH
	LastHurt = Time.get_unix_time_from_system()

func damage(amount):
	if Time.get_unix_time_from_system()*1000-LastHurt < 450:
		return
	LastHurt = Time.get_unix_time_from_system()*1000
	var old_health = Health
	Health = clamp(Health-amount,0,MAX_HEALTH)
	health_changed.emit(Health,old_health)
