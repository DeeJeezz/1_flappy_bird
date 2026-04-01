extends RigidBody2D


const DEATH_GRAVITY_SCALE: int = 2
const DEATH_GROUP_NAME: String = 'Death'

const JUMP_VELOCITY: float = -450.0

const FLY_ROTATION: float = 30.0
const FLY_ROTATION_VELOCITY_MARGIN: float = 150.0
const FLY_ROTATION_SPEED: float = 1.1

var _is_dead: bool = false


@export var sprite: Sprite2D


func _rotate_on_move() -> void:
	
	var fly_rotation: float = 0.0
	
	if linear_velocity.y > FLY_ROTATION_VELOCITY_MARGIN:
		fly_rotation = FLY_ROTATION
	elif linear_velocity.y < FLY_ROTATION_VELOCITY_MARGIN:
		fly_rotation = -FLY_ROTATION
		
	sprite.rotation_degrees = move_toward(
		sprite.rotation_degrees,
		fly_rotation,
		FLY_ROTATION_SPEED,
	)


func _process(_delta: float) -> void:
	if !_is_dead:
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept"):
			linear_velocity.y = JUMP_VELOCITY
			
		_rotate_on_move()


func _on_body_entered(body: Node) -> void:
	if !_is_dead:
		if body.is_in_group(DEATH_GROUP_NAME):
			Signals.game_over.emit()
			_is_dead = true
			gravity_scale = DEATH_GRAVITY_SCALE
