extends KinematicBody2D

var DEBRISSCENE = preload("res://Scenes/Debris.tscn")

export(bool) var DashEnabled = false
export(bool) var DoubleJumpEnabled = false

signal Died

onready var SpriteNode = $Sprite
onready var AnimationPlayerNode = $AnimationPlayer
onready var DashTween = $DashTween
onready var DashParticles = $DashParticles

var Motion = Vector2(0.0, 0.0)
var DashBonus = 0.0

var CoyoteTime = 0.0
var JumpBoost = 0.0
var HasDash = true
var CanDash = true
var HasDoubleJump = true
var UsedDoubleJump = false
var Alive = true
var HasControl = true

func _physics_process(delta):
	if Alive:
		Motion.y = min(Motion.y + (240.0 * delta), 300.0)
		
		if Motion.x < 0.0:
			SpriteNode.flip_h = true
		elif Motion.x > 0.0:
			SpriteNode.flip_h = false
		
		var isOnFloor = is_on_floor()
		
		var xMove = 0.0
		if SpriteNode.flip_h:
			xMove -= DashBonus
		else:
			xMove += DashBonus
		if HasControl:
			if Input.is_action_pressed("ui_left"):
				xMove += -20.0
			if Input.is_action_pressed("ui_right"):
				xMove += 20.0
			if Input.is_action_pressed("ui_up"):
				if CoyoteTime > 0.0:
					HasDoubleJump = false
					UsedDoubleJump = false
					CoyoteTime = 0.0
					JumpBoost = 5.0
					Motion.y = -50.0
					SoundHandler.PlaySound("blip2")
				elif JumpBoost > 0.0:
					Motion.y -= JumpBoost
					JumpBoost = max(JumpBoost - (delta * 10.0), 0.0)
				elif DoubleJumpEnabled and HasDoubleJump and not UsedDoubleJump:
					UsedDoubleJump = true
					JumpBoost = 5.0
					Motion.y = -50.0
					SoundHandler.PlaySound("blip5")
			else:
				JumpBoost = 0.0
				HasDoubleJump = true
			if Input.is_action_just_pressed("Dash") and DashEnabled and HasDash and CanDash:
				HasDash = false
				CanDash = false
				DashTween.interpolate_property(self, "DashBonus", 200.0, 0.0, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				DashTween.start()
				DashParticles.emitting = true
				SoundHandler.PlaySound("blip9")
		
		Motion.x = xMove
		
		Motion = move_and_slide_with_snap(Motion, Vector2(0.0, -32.0), Vector2(0.0, -1.0), false, 4, 0.785398, false)
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			var collider = collision.collider
			if collider is RigidBody2D:
				collider.apply_central_impulse(-collision.normal * 30.0)
		
		var moving = false
		if Motion.x < -1.0:
			moving = true
		elif Motion.x > 1.0:
			moving = true
		if isOnFloor:
			CoyoteTime = 0.1
			HasDash = true
			if moving:
				SwitchAnimation(AnimationPlayerNode, "Walk")
			else:
				SwitchAnimation(AnimationPlayerNode, "Idle")
		else:
			CoyoteTime -= delta
			if Motion.y < 0.0:
				SwitchAnimation(AnimationPlayerNode, "Jump")
			elif Motion.y > 0.0:
				SwitchAnimation(AnimationPlayerNode, "Fall")

func SwitchAnimation(animationPlayer, animation):
	if animationPlayer.current_animation != animation:
		animationPlayer.play(animation)

func Die():
	if Alive:
		Alive = false
		visible = false
		collision_layer = 0
		collision_mask = 0
		var parentNode = get_parent()
		var pos = get_position()
		for _i in range(5):
			var debris = DEBRISSCENE.instance()
			debris.set_position(pos)
			debris.linear_velocity = Vector2(rand_range(-10.0, 10.0), rand_range(-100.0, -20.0))
			parentNode.call_deferred("add_child", debris)
		SoundHandler.PlaySound("hit3")
		emit_signal("Died")

func _on_DamageDetector_body_entered(_body):
	Die()

func _on_DashTween_tween_all_completed():
	CanDash = true
	DashParticles.emitting = false
