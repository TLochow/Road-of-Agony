extends RigidBody2D

func _on_Timer_timeout():
	var tween = $Tween
	var spriteNode = $Sprite
	tween.interpolate_property(spriteNode, "scale", spriteNode.scale, Vector2(0.0, 0.0), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_Tween_tween_all_completed():
	call_deferred("queue_free")
