extends Node2D

var chain = []
var completed = 0

@export var LEN = 6
@export var PLAYER := CharacterBody2D

const characters = "ERZXCVB"

func generateChain():
	for i in LEN:
		chain.append(characters[randi_range(0,characters.length()-1)])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generateChain()
	$Label.text = chain[0]
	$ProgressBar.max_value = $Timer.wait_time
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if completed < LEN:
		$ProgressBar.value = $Timer.time_left
		if Input.is_key_pressed(OS.find_keycode_from_string(chain[completed])):
			$AudioStreamPlayer2D.pitch_scale = randf_range(0.8,1.2)
			$AudioStreamPlayer2D.play()
			completed+=1
			if completed < chain.size():
				$Label.text = chain[completed]
			else:
				$Complete.play()
				$Label.text = ""
				$ProgressBar.visible = false
	else:
		$Label.text = ""
		$ProgressBar.visible = false


func _on_timer_timeout() -> void:
	if completed < LEN:
		PLAYER.HEALTH_COMPONENT.damage(1)
	queue_free()
