extends Control
class_name dialog

var total_characters = 0
var type_speed = 2
var typing = false

func dialog(n,tex):
	$Label.text = n
	$RichTextLabel.text = tex
	total_characters = tex.length()
	$RichTextLabel.visible_characters = 0
	typing = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if typing == true:
		if $RichTextLabel.visible_characters < total_characters:
			$RichTextLabel.visible_characters+=type_speed
		else:
			typing = false
