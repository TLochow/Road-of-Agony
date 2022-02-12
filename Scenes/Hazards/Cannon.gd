extends StaticBody2D

var CANNONBALLSCENE = preload("res://Scenes/Hazards/CannonBall.tscn")

export(bool) var Active = true
export(float) var SpawnCooldown = 1.0
export(float) var InitialWaitTime = 0.0
export(float) var BallLaunchSpeed = 100.0

var BallVector = Vector2(0.0, 0.0)

func _ready():
	if Active:
		BallVector = Vector2(cos(rotation), sin(rotation)) * BallLaunchSpeed
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
	var ball = CANNONBALLSCENE.instance()
	ball.linear_velocity = BallVector
	add_child(ball)
	SoundHandler.PlaySound("C5")

func Activate():
	if not Active:
		Active = true
		_ready()

func Deactivate():
	if Active:
		Active = false
		$Timer.stop()
