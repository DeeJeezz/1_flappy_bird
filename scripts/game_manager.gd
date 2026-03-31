extends Node2D


const _SPAWN_OFFSET_X: float = 100.0


@onready var wall_scene: PackedScene = preload("res://scenes/wall.tscn")

@export var wall_spawn_timer: Timer
@export var walls: Node2D

var _screen_size: Vector2
var _lower_wall_spawn_position: Vector2
var _upper_wall_spawn_position: Vector2


func _ready() -> void:
	_screen_size = get_viewport_rect().size
	
	_lower_wall_spawn_position = Vector2(
		_screen_size.x + _SPAWN_OFFSET_X,
		0,
	)
	_upper_wall_spawn_position = Vector2(
		_screen_size.x + _SPAWN_OFFSET_X,
		_screen_size.y,
	)


func _randomize_wall_height(wall: Wall) -> void:
	wall.scale.y = randf_range(1, 2)
	


func _spawn_walls() -> void:
	var lower_wall: Wall = wall_scene.instantiate()
	lower_wall.position = _lower_wall_spawn_position
	_randomize_wall_height(lower_wall)
	walls.add_child(lower_wall)
	var upper_wall: Wall = wall_scene.instantiate()
	upper_wall.position = _upper_wall_spawn_position
	_randomize_wall_height(upper_wall)
	walls.add_child(upper_wall)


func _on_wall_spawn_timer_timeout() -> void:
	_spawn_walls()
