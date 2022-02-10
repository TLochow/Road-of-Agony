extends Control

onready var LeveLabel = $LevelLabel
onready var UITween = $ColorRect/Tween
onready var UIColorRect = $ColorRect

var SelectedLevel = 1
var MaxLevel = 100
var StartLevel = false

func _ready():
	SelectedLevel = LevelHandler.CurrentLevel
	SetLabelText()
	UITween.interpolate_property(UIColorRect, "rect_position", Vector2(0.0, 0.0), Vector2(0.0, 48.0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	UITween.start()

func _input(event):
	if event.is_action_pressed("Dash"):
		StartLevel = true
		UITween.interpolate_property(UIColorRect, "rect_position", Vector2(0.0, -48.0), Vector2(0.0, 0.0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		UITween.start()
		SoundHandler.PlaySound("soundtest")
	elif event.is_action_pressed("ui_up"):
		SelectedLevel += 10
		SoundHandler.PlaySound("blip5")
	elif event.is_action_pressed("ui_down"):
		SelectedLevel -= 10
		SoundHandler.PlaySound("blip5")
	elif event.is_action_pressed("ui_right"):
		SelectedLevel += 1
		SoundHandler.PlaySound("blip5")
	elif event.is_action_pressed("ui_left"):
		SelectedLevel -= 1
		SoundHandler.PlaySound("blip5")
	elif event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	SelectedLevel = clamp(SelectedLevel, 1, MaxLevel)
	SetLabelText()

func _on_Tween_tween_all_completed():
	if StartLevel:
		LevelHandler.CurrentLevel = SelectedLevel
		LevelHandler.LoadLevel(false)

func SetLabelText():
	var levelText = "LEVEL:" + str(SelectedLevel)
	if SaveHandler.LoadLevelCompleted(SelectedLevel):
		levelText += " (Done)"
	LeveLabel.text = levelText
