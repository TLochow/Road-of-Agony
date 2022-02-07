extends StaticBody2D

export(float) var Scale = 1.0

onready var SpriteNode = $Sprite

func _ready():
	SpriteNode.scale *= Scale
	var shape = CircleShape2D.new()
	shape.set_radius(2.0 * Scale)
	$CollisionShape2D.shape = shape

func _process(delta):
	SpriteNode.rotate(delta * 20.0)
