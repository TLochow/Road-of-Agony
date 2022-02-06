extends Node

func LoadLevelCompleted(level):
	var completed = false
	var config = ConfigFile.new()
	var result = config.load("user://save.cfg")
	if result == OK:
		completed = config.get_value("completion", str(level), false)
	return completed

func SaveLevelCompleted(level):
	var config = ConfigFile.new()
	var _result = config.load("user://save.cfg")
	config.set_value("completion", str(level), true)
	config.save("user://save.cfg")
