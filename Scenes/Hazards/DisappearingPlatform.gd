extends StaticBody2D

onready var AnimPlayer = $AnimationPlayer
onready var Detector = $Detector

var Collapsing = false

func Collapse():
	collision_layer = 0
	SoundHandler.PlaySound("hit2")

func Reform():
	collision_layer = 1
	Detector.collision_mask = 4
	Collapsing = false

func _on_Detector_body_entered(_body):
	if not Collapsing:
		Collapsing = true
		AnimPlayer.stop()
		AnimPlayer.play("Collapse")
		Detector.collision_mask = 0
		SoundHandler.PlaySound("blip8")
