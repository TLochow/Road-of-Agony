extends Area2D

export(int) var Type = 1

signal Collected

onready var SpriteNode = $Sprite

var Collected = false

func _ready():
	SpriteNode.frame = Type - 1

func _on_Powerup_body_entered(body):
	if not Collected:
		Collected = true
		$Sparkle.emitting = false
		$Burst.emitting = true
		SpriteNode.visible = false
		SoundHandler.PlaySound("jingle1")
		match(Type):
			1:
				body.DashEnabled = true
		emit_signal("Collected")
