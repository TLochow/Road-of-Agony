extends AnimationPlayer

func _ready():
	play("PlayLevel")

func io(key, length):
	Input.action_press(key)
	yield(get_tree().create_timer(length), "timeout")
	Input.action_release(key)
