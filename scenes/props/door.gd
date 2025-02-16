class_name Door
extends Node2D

signal opened

@onready var door_sprite: Sprite2D = $DoorSprite

@export var duration_open : float
@export var enemies : Array[BasicEnemy]


enum state {CLOSED, OPENING, OPENED}

var door_height := 0
var current_state = state.CLOSED
var time_start_opening := Time.get_ticks_msec()


func _ready() -> void:
	door_height = door_sprite.texture.get_height()

func open() -> void:
	if current_state == state.CLOSED:
		current_state = state.OPENING
		time_start_opening = Time.get_ticks_msec()

func _process(_delta: float) -> void:
	if current_state == state.OPENING:
		if Time.get_ticks_msec() - time_start_opening > duration_open:
			current_state = state.OPENED
			door_sprite.position = Vector2.UP * door_height
			opened.emit()
		else:
			var progress := (Time.get_ticks_msec() - time_start_opening) / duration_open
			door_sprite.position = lerp(Vector2.ZERO, Vector2.UP * door_height, progress)
