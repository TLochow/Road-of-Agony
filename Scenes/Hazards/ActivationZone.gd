extends Area2D

enum ActivationModes {
	Activate,
	Deactivate
}

export(ActivationModes) var ActivationMode = ActivationModes.Activate

var Activated = false

func _on_ActivationZone_body_entered(_body):
	if not Activated:
		Activated = true
		if ActivationMode == ActivationModes.Activate:
			get_parent().Activate()
		else:
			get_parent().Deactivate()
