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
		_screen_size.y,
	)
	_upper_wall_spawn_position = Vector2(
		_screen_size.x + _SPAWN_OFFSET_X,
		0,
	)


func _randomize_passage_between_walls(lower_wall: Wall, upper_wall: Wall) -> void:
	upper_wall.position.y += randi_range(-50, 150)
	lower_wall.position.y = upper_wall.position.y + randi_range(450, 550)
		
	

func _spawn_walls() -> void:
	var lower_wall: Wall = wall_scene.instantiate()
	lower_wall.position = _lower_wall_spawn_position
	walls.add_child(lower_wall)
	var upper_wall: Wall = wall_scene.instantiate()
	upper_wall.position = _upper_wall_spawn_position
	upper_wall.rotation_degrees = 180
	walls.add_child(upper_wall)
	
	_randomize_passage_between_walls(lower_wall, upper_wall)


func _on_wall_spawn_timer_timeout() -> void:
	_spawn_walls()
