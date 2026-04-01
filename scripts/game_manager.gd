extends Node2D


const _SPAWN_OFFSET_X: float = 100.0


@onready var wall_scene: PackedScene = preload("res://scenes/wall.tscn")
@onready var score_area_scene: PackedScene = preload("res://scenes/score_area.tscn")

@export var wall_spawn_timer: Timer
@export var walls: Node2D
@export var ui: UI


var _screen_size: Vector2
var _lower_wall_spawn_position: Vector2
var _upper_wall_spawn_position: Vector2
var _score_area_position: Vector2
var _current_score: int = 0
var _game_over: bool = false


func _ready() -> void:
	# Connect game over signal.
	Signals.game_over.connect(_on_game_over)
	
	# Setup UI.
	ui.set_score(_current_score)
	
	# Initial settings.
	_screen_size = get_viewport_rect().size
	
	# Initializa constants.
	_lower_wall_spawn_position = Vector2(
		_screen_size.x + _SPAWN_OFFSET_X,
		_screen_size.y,
	)
	_upper_wall_spawn_position = Vector2(
		_screen_size.x + _SPAWN_OFFSET_X,
		0,
	)
	_score_area_position = Vector2(
		_screen_size.x + _SPAWN_OFFSET_X + 60,
		_screen_size.y / 2,
	)
	
	
func _process(_delta: float) -> void:
	if _game_over:
		# Restart.
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene()


func _randomize_passage_between_walls(lower_wall: Wall, upper_wall: Wall) -> void:
	upper_wall.position.y += randi_range(-50, 150)
	# TODO: Сделать расчет расстояния между трубами
	lower_wall.position.y = upper_wall.position.y + randi_range(450, 550)


func _spawn_walls() -> void:
	var lower_wall: Wall = wall_scene.instantiate()
	lower_wall.position = _lower_wall_spawn_position
	walls.add_child(lower_wall)
	var upper_wall: Wall = wall_scene.instantiate()
	upper_wall.position = _upper_wall_spawn_position
	upper_wall.rotation_degrees = 180
	
	var score_area: Area2D = score_area_scene.instantiate()
	upper_wall.add_child(score_area)
	score_area.global_position = _score_area_position
	walls.add_child(upper_wall)
	
	_randomize_passage_between_walls(lower_wall, upper_wall)


func _on_wall_spawn_timer_timeout() -> void:
	_spawn_walls()
	
	
func _on_game_over() -> void:
	_game_over = true
	ui.game_over()
	wall_spawn_timer.timeout.disconnect(_on_wall_spawn_timer_timeout)
	#walls.queue_free()
