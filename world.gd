extends Node2D

@onready var player: CharacterBody2D = $ActorsContainer/Player
@onready var camera: Camera2D = $Camera

func _process(_delta: float) -> void:
	if player.position.x > camera.position.x:
		camera.position.x = player.position.x
	
	
