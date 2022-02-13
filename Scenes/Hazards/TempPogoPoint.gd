extends StaticBody2D

onready var AnimPlayer = $AnimationPlayer
onready var DefaultParticles = $Particles2D
onready var BurtsParticles = $BurstParticles
onready var RespawnParticles = $RespawnParticles

var Bursted = false

func Burst():
	collision_layer = 0
	DefaultParticles.emitting = false
	BurtsParticles.emitting = true

func Respawn():
	RespawnParticles.emitting = true

func Respawned():
	collision_layer = 2
	Bursted = false
	DefaultParticles.emitting = true

func _on_PogoDetector_area_entered(_area):
	if not Bursted:
		Bursted = true
		AnimPlayer.play("Burst")
