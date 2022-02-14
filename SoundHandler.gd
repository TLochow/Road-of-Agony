extends Node2D

var PreviousSound

func PlaySound(soundName):
	if PreviousSound:
		PreviousSound.stop()
	PreviousSound = get_node(soundName)
	PreviousSound.play()
