class_name TogglePicker
extends ActivableControl

@onready var value_label: Label = $ValueLabel

func refresh() -> void:
	value_label.text = "ON" if current_value == 1 else "OFF"

func _process(_delta: float) -> void:
	if is_active and has_input_toggle():
		set_value(1 if current_value == 0 else 0)

func has_input_toggle() -> bool:
	var actions := ["Left", "Right", "Attack", "Jump"]
	for action in actions:
		if Input.is_action_just_pressed(action):
			return true
	return false
