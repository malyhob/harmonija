extends Control

signal finish()

@export var TEXT = ""
@export var TIME = 5

func _ready() -> void:
	$Timer.start(TIME)
	$Label.text = TEXT

func _process(_delta: float) -> void:
	$TimeText.text = str(int($Timer.time_left)+1)

func _on_timer_timeout() -> void:
	finish.emit()
	call_deferred("queue_free")
