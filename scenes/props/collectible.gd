class_name  Collectible
extends Area2D

const GRAVITY := 600.0

@export var auto_destroy : bool
@export var current_type : type
@export var damage : int
@export var knockdown_intensity : float
@export var speed : float

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collectible_sprite: Sprite2D = $CollectibleSprite
@onready var damage_emitter: Area2D = $DamageEmitter


enum state {FALL, GROUNDED, FLY}
enum type {KNIFE, GUN, FOOD}

var anim_map := {
	state.FALL : "Fall",
	state.GROUNDED : "Grounded",
	state.FLY : "Fly",
}

var direction := Vector2.ZERO

var height := 0.0
var height_speed := 0.0

var velocity := Vector2.ZERO

var current_state = state.FALL

func _ready() -> void:
	height_speed = knockdown_intensity
	if current_state == state.FLY:
		velocity = direction * speed
	damage_emitter.area_entered.connect(on_emit_damage.bind())
	damage_emitter.body_exited.connect(on_exit_screen.bind())
	damage_emitter.position = Vector2.UP * height
	

func handle_animations() -> void:
	animation_player.play(anim_map[current_state])

func _process(delta: float) -> void:
	handle_fall(delta)
	handle_animations()
	collectible_sprite.flip_h = velocity.x < 0
	collectible_sprite.position = Vector2.UP * height
	position += velocity * delta
	monitorable = current_state == state.GROUNDED
	damage_emitter.monitoring = current_state == state.FLY
	
func handle_fall(delta: float) -> void:
	if current_state == state.FALL:
		height += height_speed * delta
		if auto_destroy:
			modulate.a -= delta
		if height < 0:
			height = 0
			current_state = state.GROUNDED
			if auto_destroy:
				queue_free()
		else:
			height_speed -= GRAVITY * delta

func on_emit_damage(receiver: DamageReceiver) -> void:
	receiver.damage_received.emit(damage, direction, DamageReceiver.HitType.KNOCKDOWN)
	queue_free()

func on_exit_screen(_wall: AnimatableBody2D) -> void:
	queue_free()
