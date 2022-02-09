extends StaticBody2D

onready var BeamRect = $ColorRect
onready var ColShape = $CollisionShape2D
onready var BeamTween = $Tween

var State = 1

func _ready():
	var shape = RectangleShape2D.new()
	shape.set_extents(Vector2(0.0, 4.0))
	ColShape.shape = shape

func _on_Timer_timeout():
	collision_layer = 2
	BeamTween.interpolate_property(BeamRect, "rect_scale", Vector2(0.0, 4.0), Vector2(400.0, 4.0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	BeamTween.interpolate_property(ColShape, "position", Vector2(0.0, 0.0), Vector2(200.0, 0.0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	BeamTween.interpolate_property(ColShape.shape, "extents", Vector2(0.0, 4.0), Vector2(200.0, 4.0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	BeamTween.start()
	SoundHandler.PlaySound("crust")

func _on_Tween_tween_all_completed():
	if State == 1:
		State = 2
		$Particles2D.queue_free()
		BeamTween.interpolate_property(BeamRect, "rect_scale", Vector2(400.0, 4.0), Vector2(0.0, 4.0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		BeamTween.interpolate_property(BeamRect, "rect_position", Vector2(0.0, -1.0), Vector2(400.0, -1.0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		BeamTween.interpolate_property(ColShape, "position", Vector2(200.0, 0.0), Vector2(400.0, 0.0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		BeamTween.interpolate_property(ColShape.shape, "extents", Vector2(200.0, 4.0), Vector2(0.0, 4.0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		BeamTween.start()
	else:
		queue_free()
