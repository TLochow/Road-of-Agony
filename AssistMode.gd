extends Node2D

onready var AnimPlayer = $CanvasLayer/AnimationPlayer

var Invincible = false
var UnlimitedDoubleJumps = false
var HalfSpeed = false

func _unhandled_input(event):
	var doneSomething = false
	if event.is_action_pressed("Assist_Invincible"):
		doneSomething = true
		Invincible = not Invincible
	elif event.is_action_pressed("Assist_DoubleJumps"):
		doneSomething = true
		UnlimitedDoubleJumps = not UnlimitedDoubleJumps
	elif event.is_action_pressed("Assist_Speed"):
		doneSomething = true
		HalfSpeed = not HalfSpeed
		if HalfSpeed:
			Engine.time_scale = 0.5
		else:
			Engine.time_scale = 1.0
	
	if doneSomething:
		SoundHandler.PlaySound("ring1")
		if Invincible or UnlimitedDoubleJumps or HalfSpeed:
			AnimPlayer.play("Active")
		else:
			AnimPlayer.play("Inactive")
