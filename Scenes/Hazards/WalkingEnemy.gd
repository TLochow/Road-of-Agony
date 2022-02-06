extends KinematicBody2D

export(bool) var GoingRight = false
export(float) var WalkingSpeed = 5.0

var Motion = Vector2(0.0, 0.0)
onready var SpriteNode = $Sprite
onready var LeftWallCast = $WallCastLeft
onready var RightWallCast = $WallCastRight
onready var LeftGroundCast = $GroundCastLeft
onready var RightGroundCast = $GroundCastRight

func _ready():
	$AnimationPlayer.play("Walk")

func _physics_process(delta):
	Motion.y = min(Motion.y + (240.0 * delta), 300.0)
	SpriteNode.flip_h = GoingRight
	
	if GoingRight:
		Motion.x = WalkingSpeed
		if RightWallCast.is_colliding() or not RightGroundCast.is_colliding():
			GoingRight = false
	else:
		Motion.x = -WalkingSpeed
		if LeftWallCast.is_colliding() or not LeftGroundCast.is_colliding():
			GoingRight = true
	
	Motion = move_and_slide_with_snap(Motion, Vector2(0.0, -32.0), Vector2(0.0, -1.0), false, 4, 0.785398, false)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.collider
		if collider is RigidBody2D:
			collider.apply_central_impulse(-collision.normal * 30.0)
