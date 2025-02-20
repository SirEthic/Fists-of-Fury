class_name LabelPicker
extends ActivableControl

signal press

func _process(_delta: float) -> void:
	if is_active and (Input.is_action_just_pressed("Attack") or Input.is_action_just_pressed("Jump")):
		press.emit()
