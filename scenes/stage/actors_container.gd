extends Node2D

const SHOT_PREFAB := preload("res://scenes/props/shot.tscn")

const PREFAB_MAP := {
	Collectible.type.KNIFE: preload("res://scenes/props/knife.tscn"),
	Collectible.type.GUN: preload("res://scenes/props/gun.tscn"),
	Collectible.type.FOOD: preload("res://scenes/props/food.tscn")
}

func _ready() -> void:
	EntityManager.spawn_collectible.connect(on_spawn_collectible.bind())
	EntityManager.spawn_shot.connect(on_spawn_shot.bind())

func on_spawn_collectible(type: Collectible.type, initial_state: Collectible.state, collectible_global_position: Vector2, collectible_direction: Vector2, initial_height: float, auto_destroy: bool) -> void:
	var collectible : Collectible = PREFAB_MAP[type].instantiate()
	collectible.current_state = initial_state
	collectible.height = initial_height
	collectible.global_position = collectible_global_position
	collectible.direction = collectible_direction
	collectible.auto_destroy = auto_destroy
	call_deferred("add_child", collectible)

func on_spawn_shot(gun_root_position: Vector2, distance_travelled: float, height: float) -> void:
	var shot : Shot = SHOT_PREFAB.instantiate()
	add_child(shot)
	shot.position = gun_root_position
	shot.initialize(distance_travelled, height)
