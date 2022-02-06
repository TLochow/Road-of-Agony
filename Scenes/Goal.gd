extends Area2D

signal GoalReached

func _on_Goal_body_entered(_body):
	emit_signal("GoalReached")
