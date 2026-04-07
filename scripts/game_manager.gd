extends Node2D


const _SPAWN_OFFSET_X: float = 100.0


@onready var obstacle_scene: PackedScene = preload("res://scenes/obstacle.tscn")
@onready var obstacle_spawn_timer: Timer = $ObstacleSpawnTimer

@export var obstacles: Node2D
@export var ui: UI


var _screen_size: Vector2
var _obstacle_spawn_position: Vector2
var _current_score: int:
	set(value):
		_current_score = value
		ui.set_score(_current_score)

var _game_over: bool = false


func _ready() -> void:
	# Connect signals.
	Signals.game_over.connect(_on_game_over)
	Signals.obstacle_passed.connect(_on_obstacle_passed)
	
	# Setup UI.
	_current_score = 0
	
	# Initial settings.
	_screen_size = get_viewport_rect().size
	_obstacle_spawn_position = Vector2(
		_screen_size.x + _SPAWN_OFFSET_X,
		_screen_size.y / 2,
	)
	
	
func _process(_delta: float) -> void:
	if _game_over:
		# Restart.
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene()


func _spawn_obstacle() -> void:
	var obstacle: Obstacle = obstacle_scene.instantiate()
	obstacles.add_child(obstacle)
	obstacle.position = _obstacle_spawn_position
	obstacle.randomize_passage_height()
	


func _on_wall_spawn_timer_timeout() -> void:
	_spawn_obstacle()
	
	
func _on_obstacle_passed() -> void:
	_current_score += 1
	
	
func _on_game_over() -> void:
	_game_over = true
	ui.game_over()
	obstacle_spawn_timer.timeout.disconnect(_on_wall_spawn_timer_timeout)
	obstacles.process_mode = Node.PROCESS_MODE_DISABLED
