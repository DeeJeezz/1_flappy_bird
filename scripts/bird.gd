extends RigidBody2D


const JUMP_VELOCITY = -450.0


@export var sprite: Sprite2D


func _process(_delta: float) -> void:
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		linear_velocity.y = JUMP_VELOCITY
		
	if linear_velocity.y > 150:
		sprite.rotation_degrees = 30
	elif linear_velocity.y <= 150 && linear_velocity.y >= -150:
		sprite.rotation_degrees = 0
	else:
		sprite.rotation_degrees = -30


func _on_body_entered(body: Node) -> void:
	if body is Wall:
		print_debug('Game over')
		queue_free()
