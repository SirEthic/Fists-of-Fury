extends Node2D

const SHOT_PREFAB := preload("res://scenes/props/shot.tscn")

const PREFAB_MAP := {
	Collectible.type.KNIFE: preload("res://scenes/props/knife.tscn"),
	Collectible.type.GUN: preload("res://scenes/props/gun.tscn"),
	Collectible.type.FOOD: preload("res://scenes/props/food.tscn")
}

const ENEMY_MAP := {
	Character.Type.PUNK : preload("res://scenes/characters/basic_enemy.tscn"),
	Character.Type.GOON : preload("res://scenes/characters/goon_enemy.tscn"),
	Character.Type.THUG : preload("res://scenes/characters/thug_enemy.tscn"),
	Character.Type.BOUNCER : preload("res://scenes/characters/igor_boss.tscn"),
}

@export var player : Player

var doors : Array[Door] = []

func _init() -> void:
	EntityManager.orphan_actor.connect(on_orphan_actor.bind())
	EntityManager.spawn_collectible.connect(on_spawn_collectible.bind())
	EntityManager.spawn_shot.connect(on_spawn_shot.bind())
	EntityManager.spawn_enemy.connect(on_spawn_enemy.bind())
	

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

func on_spawn_enemy(enemy_data: EnemyData) -> void:
	var enemy : Character = ENEMY_MAP[enemy_data.type].instantiate()
	enemy.global_position = enemy_data.global_position
	enemy.player = player
	enemy.height = enemy_data.height
	enemy.current_state = enemy_data.current_state
	if enemy_data.door_index > -1:
		enemy.assign_door(doors[enemy_data.door_index])
	add_child(enemy)

func on_orphan_actor(orphan: Node2D) -> void:
	if orphan is Door:
		doors.append(orphan)
	orphan.reparent(self)
