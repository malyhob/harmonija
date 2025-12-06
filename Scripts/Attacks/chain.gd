extends Node2D

var chain = []
var completed = 0

@export var LEN = 6
@export var PLAYER := CharacterBody2D

const characters = "ZXCVBNER"

func generateChain():
	for i in LEN:
		chain.append(characters[randi_range(0,characters.length()-1)])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generateChain()
	$Label.text = chain[0]
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if completed < LEN:
		$Label2.text = str(int($Timer.time_left))
		if Input.is_key_pressed(OS.find_keycode_from_string(chain[completed])):
			completed+=1
			if completed < chain.size():
				$Label.text = chain[completed]
			else:
				$Label.text = ""
				$Label2.text = ""
	else:
		$Label.text = ""
		$Label2.text = ""


func _on_timer_timeout() -> void:
	if completed < LEN:
		PLAYER.HEALTH_COMPONENT.damage(1)
	queue_free()
