extends Node2D

onready var Player = $Player
onready var Goal = $Goal

onready var UITween = $UI/Tween
onready var UIColorRect = $UI/ColorRect

var LevelFinished = false

func _ready():
	UIColorRect.visible = true
	UITween.interpolate_property(UIColorRect, "rect_position", Vector2(0.0, 0.0), Vector2(0.0, 48.0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	UITween.start()
	Player.connect("Died", self, "PlayerDied")
	Goal.connect("GoalReached", self, "GoalReached")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		SoundHandler.PlaySound("odd2")
		UITween.interpolate_property(UIColorRect, "rect_position", Vector2(0.0, -48.0), Vector2(0.0, 0.0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		UITween.start()
		yield(UITween, "tween_all_completed")
		var _result = get_tree().change_scene("res://Scenes/LevelSelector.tscn")

func PlayerDied():
	LoadLevel(false)

func GoalReached():
	if not LevelFinished:
		LevelFinished = true
		Player.HasControl = false
		SoundHandler.PlaySound("good3")
		LoadLevel(true)

func LoadLevel(nextLevel):
	UITween.interpolate_property(UIColorRect, "rect_position", Vector2(0.0, -48.0), Vector2(0.0, 0.0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	UITween.start()
	yield(UITween, "tween_all_completed")
	LevelHandler.LoadLevel(nextLevel)
