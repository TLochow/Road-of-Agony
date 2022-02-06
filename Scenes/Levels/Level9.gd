extends Node2D

func _ready():
	$Powerup.connect("Collected", self, "PowerupCollected")

func PowerupCollected():
	$Label.visible = true
