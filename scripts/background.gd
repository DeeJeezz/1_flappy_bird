extends Node2D


const BACK_LAYER_SPEED: float = 200.0
const FRONT_LAYER_SPEED: float = 400.0


@export var back_layer: Node2D
@export var front_layer: Node2D

var _screen_size: Vector2
var _duplicate_border_x: float


func _ready() -> void:
	_screen_size = get_viewport_rect().size
	_duplicate_border_x = -_screen_size.x * 2


func _process(delta: float) -> void:
	back_layer.position.x -= BACK_LAYER_SPEED * delta
	front_layer.position.x -= FRONT_LAYER_SPEED * delta
	
	if back_layer.position.x < _duplicate_border_x:
		for child in back_layer.get_children():
			
