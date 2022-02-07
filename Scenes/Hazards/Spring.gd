extends Area2D

export(float) var Strength = 200.0

onready var SpriteNode = $Sprite
onready var TimerNode = $Timer

func _on_Spring_body_entered(body):
	body.Motion.y = -Strength
	body.RefreshJumps()
	SpriteNode.frame = 1
	TimerNode.start()
	SoundHandler.PlaySound("hit6")

func _on_Timer_timeout():
	SpriteNode.frame = 0
