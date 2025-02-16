class_name EnemyData
extends Resource

const DROP_HEIGHT := 50

@export var door_index : int
@export var height : int
@export var type : Character.Type
@export var global_position : Vector2
@export var current_state : Character.state

func _init(character_type : Character.Type  = Character.Type.PUNK, position : Vector2 = Vector2.ZERO, assigned_door_index : int = -1) -> void:
	door_index = assigned_door_index
	type = character_type
	if position.y < 0:
		height = DROP_HEIGHT
		global_position = position + Vector2.DOWN * DROP_HEIGHT
		current_state = Character.state.DROP
	else:
		global_position = position
		current_state = Character.state.IDLE
	
