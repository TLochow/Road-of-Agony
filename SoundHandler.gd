extends Node2D

onready var file = File.new()
onready var AudioPlayer = $AudioStreamPlayer

var PreviousSound = ""

func PlaySound(soundName):
	AudioPlayer.stop()
	if PreviousSound == soundName:
		AudioPlayer.play()
	else:
		var filePath = "res://Sounds/nokia3310-soundpack/" + soundName + ".wav"
		if file.file_exists(filePath):
			var sound = load(filePath)
			AudioPlayer.stream = sound
			AudioPlayer.play()
			PreviousSound = soundName
