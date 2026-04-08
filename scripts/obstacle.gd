extends Node2D
class_name Obstacle

const _MOVEMENT_SPEED: float = 400.0
const _DESTROY_BORDER: float = -50.0
const _PASSAGE_NARROW_RANGE: float = 40.0
const _OBSTACLE_X_MOVEMENT: float = 80
const _OBSTACLE_Y_MOVEMENT: float = 125

@onready var upper_wall: Node2D = $UpperWall
@onready var lower_wall: Node2D = $LowerWall
@onready var score_area: Area2D = $ScoreArea


func _randomize_passage_position() -> void:
	position.y += randf_range(-_OBSTACLE_Y_MOVEMENT, _OBSTACLE_Y_MOVEMENT)
	position.x += randf_range(-_OBSTACLE_X_MOVEMENT, 0)


func randomize_passage_height() -> void:
	lower_wall.position.y -= randf_range(-_PASSAGE_NARROW_RANGE, _PASSAGE_NARROW_RANGE / 2)
	upper_wall.position.y += randf_range(-_PASSAGE_NARROW_RANGE, _PASSAGE_NARROW_RANGE / 2)
	_randomize_passage_position()


func _process(delta: float) -> void:
	position.x -= _MOVEMENT_SPEED * delta
	if position.x < _DESTROY_BORDER:
		queue_free()
