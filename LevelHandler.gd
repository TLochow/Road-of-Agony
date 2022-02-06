extends Node

var CurrentLevel = 1

func LoadLevel(nextLevel):
	if nextLevel:
		SaveHandler.SaveLevelCompleted(CurrentLevel)
		CurrentLevel += 1
	var _returnedValue = get_tree().change_scene("res://Scenes/Levels/Level" + str(CurrentLevel) + ".tscn")
