extends StaticBody2D

export(float) var Scale = 1.0
export(float) var MoveSpeed = 1.0
export(float) var MoveOffset = 0.0

onready var SpriteNode = $Sprite

var Moving = false
var MoveStartPos
var MoveVector

func _ready():
	SpriteNode.scale *= Scale
	var shape = CircleShape2D.new()
	shape.set_radius(2.0 * Scale)
	$CollisionShape2D.shape = shape
	var startNode = get_node_or_null("Start")
	var endNode = get_node_or_null("End")
	if startNode and endNode:
		Moving = true
		MoveStartPos = startNode.get_global_position()
		MoveVector = endNode.get_global_position() - MoveStartPos
		MoveOffset *= PI

func _process(delta):
	SpriteNode.rotate(delta * 20.0)
	if Moving:
		var pos = MoveStartPos + (MoveVector * (((sin((OS.get_ticks_msec() * 0.001 * MoveSpeed) + MoveOffset) + 1.0) * 0.5)))
		set_position(pos)
