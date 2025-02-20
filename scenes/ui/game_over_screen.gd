class_name GameOverScreen
extends Control

@onready var score_indicator: ScoreIndicator = $Background/MarginContainer/VBoxContainer/HBoxContainer/ScoreIndicator
@onready var timer: Timer = $Timer

var total_score := 0

func _ready() -> void:
	timer.timeout.connect(on_timer_timeout.bind())

func set_score(score: int) -> void:
	total_score = score

func on_timer_timeout() -> void:
	score_indicator.add_points(total_score)
