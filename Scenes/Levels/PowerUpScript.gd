extends Node2D

func _ready():
	var _result = $Powerup.connect("Collected", self, "PowerupCollected")

func PowerupCollected():
	$Label.visible = true
