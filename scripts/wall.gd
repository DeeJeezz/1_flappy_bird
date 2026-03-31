extends StaticBody2D
class_name Wall

const _MOVEMENT_SPEED: float = 200.0


var _screen_size: Vector2


func _ready() -> void:
	_screen_size = get_viewport_rect().size


func _process(delta: float) -> void:
	position.x -= _MOVEMENT_SPEED * delta
	if global_position.x < 0:
		queue_free()
