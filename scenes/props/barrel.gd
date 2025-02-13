extends StaticBody2D

@onready var damage_receiver: DamageReceiver = $DamageReceiver
@onready var sprite: Sprite2D = $Sprite

@export var knockback_intensity: float

enum state {IDLE, DESTROYED}

const GRAVITY := 600.0

var height : float = 0.0
var height_speed : float = 0.0
var current_state := state.IDLE
var velocity := Vector2.ZERO 

func _ready() -> void:
	damage_receiver.damage_received.connect(on_receive_damage.bind())

func _process(delta: float) -> void:
	position += velocity * delta
	sprite.position = Vector2.UP * height
	handle_air_time(delta)

func on_receive_damage(_damage: int, direction: Vector2, _hit_type: DamageReceiver.HitType) -> void:
	if current_state == state.IDLE:
		sprite.frame = 1
		height_speed = knockback_intensity * 2.5
		current_state = state.DESTROYED
		velocity = direction * knockback_intensity
	
func handle_air_time(delta: float) -> void:
	if current_state == state.DESTROYED:
		modulate.a -= delta
		height += height_speed * delta
		if height < 0:
			height = 0
			queue_free()
		else:
			height_speed -= GRAVITY * delta
