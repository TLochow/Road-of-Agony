extends Control

var Started = false

func _ready():
	randomize()
	$Sprite/AnimationPlayer.play("Wave")

func _input(event):
	if event is InputEventKey and not Started:
		Started = true
		$ColorRect/Tween.interpolate_property($ColorRect, "rect_position", Vector2(0.0, -48.0), Vector2(0.0, 0.0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$ColorRect/Tween.start()
		SoundHandler.PlaySound("odd4")

func _on_Tween_tween_all_completed():
	var _result = get_tree().change_scene("res://Scenes/LevelSelector.tscn")
