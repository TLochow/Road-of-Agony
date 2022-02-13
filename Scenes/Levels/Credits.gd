extends Node2D

func _ready():
	$Tween.interpolate_property($UI/Label, "rect_position", Vector2(0.0, 48.0), Vector2(0.0, -378.0), 30.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		var _result = get_tree().change_scene("res://Scenes/LevelSelector.tscn")
