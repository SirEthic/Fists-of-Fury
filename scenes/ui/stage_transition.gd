class_name StageTransition
extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func start_transition() -> void:
	animation_player.play("Start_Transition")

func end_transition() -> void:
	animation_player.play("End_Transition")

func on_complete_start_transition() -> void:
	animation_player.play("Interim")
	StageManager.stage_interim.emit()

func on_complete_end_transition() -> void:
	animation_player.play("Idle")
