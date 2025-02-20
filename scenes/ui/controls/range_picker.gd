class_name RangePicker
extends ActivableControl

const TICK_ON := preload("res://assets/art/ui/ui-tick-on.png")
const TICK_OFF := preload("res://assets/art/ui/ui-tick-off.png")

@onready var ticks_container: HBoxContainer = $TicksContainer

func refresh() -> void:
	var ticks := ticks_container.get_children()
	for i in range(0, current_value):
		ticks[i].texture = TICK_ON
	for i in range(current_value, ticks.size()):
		ticks[i].texture = TICK_OFF

func _process(_delta: float) -> void:
	if is_active and Input.is_action_just_pressed("Left"):
		set_value(current_value - 1)
	if is_active and Input.is_action_just_pressed("Right"):
		set_value(current_value + 1)
