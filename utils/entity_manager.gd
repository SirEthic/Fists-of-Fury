extends Node
 
signal spawn_collectible(type: Collectible.type, initial_state: Collectible.state, collectible_global_position: Vector2, collectible_direction: Vector2, initial_height: float, auto_destroy: bool)
signal spawn_shot(gun_root_position: Vector2, distance_travelled: float, height: float) 
