extends RigidBody2D

var EXPLOSIONSCENE = preload("res://Scenes/ExplosionEffect.tscn")

onready var Player = get_tree().get_nodes_in_group("Player")[0]
onready var Speed = linear_velocity.length()

var CollisionCounter = 0

func _physics_process(delta):
	var dir = (Player.get_position() - get_global_position()).normalized() * 480.0 * delta
	linear_velocity = (linear_velocity + dir).normalized() * Speed

func _on_CollisionDetector_body_entered(_body):
	CollisionCounter += 1
	if CollisionCounter > 1:
		SoundHandler.PlaySound("hit5")
		var explosion = EXPLOSIONSCENE.instance()
		explosion.set_position(get_position())
		get_parent().add_child(explosion)
		queue_free()
