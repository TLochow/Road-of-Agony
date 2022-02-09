extends Node2D

var BEAMSCENE = preload("res://Scenes/Hazards/Beam.tscn")

enum Direction {
	Up,
	Down,
	Left,
	Right
}

export(float) var SpawnCooldown = 4.0
export(float) var InitialWaitTime = 0.0
export(Direction) var BeamDirection = Direction.Left

onready var Player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	if InitialWaitTime > 0.0:
		var timer = $StartTimer
		timer.wait_time = InitialWaitTime
		timer.start()
	else:
		_on_StartTimer_timeout()

func _on_StartTimer_timeout():
	var timer = $Timer
	timer.wait_time = SpawnCooldown
	timer.start()

func _on_Timer_timeout():
	var beam = BEAMSCENE.instance()
	var posVector = Vector2(0.0, 0.0)
	var rot = 0.0
	match(BeamDirection):
		Direction.Up:
			posVector = Vector2(0.0, 200.0)
			rot = -90.0
		Direction.Down:
			posVector = Vector2(0.0, -200.0)
			rot = 90.0
		Direction.Left:
			posVector = Vector2(200.0, 0.0)
			rot = 180.0
		Direction.Right:
			posVector = Vector2(-200.0, 0.0)
	beam.set_position(Player.get_position() + posVector)
	beam.rotation_degrees = rot
	add_child(beam)

