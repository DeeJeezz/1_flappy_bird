extends Node2D


const _SPAWN_OFFSET_X: float = 100.0


@onready var obstacle_scene: PackedScene = preload("res://scenes/obstacle.tscn")
@onready var obstacle_spawn_timer: Timer = $ObstacleSpawnTimer

@export var obstacles: Node2D
@export var ui: UI

var parallaxes: Array[Node]

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
	Signals.restart_game.connect(_on_restart_game)
	
	# Setup UI.
	_current_score = 0
	
	# Initial settings.
	_screen_size = get_viewport_rect().size
	_obstacle_spawn_position = Vector2(
		_screen_size.x + _SPAWN_OFFSET_X,
		_screen_size.y / 2,
	)
	parallaxes = get_parent().find_children(
		"",
		"Parallax2D",
	)
	SaveManager.load_last_session()
	if SaveManager.last_session:
		ui.set_last_score(SaveManager.last_session["score"])
	get_tree().paused = true
	
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if get_tree().paused:
			get_tree().paused = false
			ui.game_started()
		


func _spawn_obstacle() -> void:
	var obstacle: Obstacle = obstacle_scene.instantiate()
	obstacles.add_child(obstacle)
	obstacle.position = _obstacle_spawn_position
	obstacle.randomize_passage_height()
	


func _on_wall_spawn_timer_timeout() -> void:
	_spawn_obstacle()
	
	
func _on_obstacle_passed() -> void:
	_current_score += 1
	
	
func _on_restart_game() -> void:
	get_tree().reload_current_scene()
	
	
func _on_game_over() -> void:
	_game_over = true
	# Show game over UI.
	ui.game_over(_current_score)
	# Disable walls spawning.
	obstacle_spawn_timer.timeout.disconnect(_on_wall_spawn_timer_timeout)
	# Disable walls moving.
	obstacles.process_mode = Node.PROCESS_MODE_DISABLED
	# Disable parallax effect.
	parallaxes.map(func(element): element.autoscroll.x = 0)
	SaveManager.save_current_session(
		{
			"score": _current_score, 
			"date": Time.get_datetime_string_from_system(true),
		},
	)
