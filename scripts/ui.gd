extends Control
class_name UI

@export var game_over_panel: Panel
@export var score_label: Label


func _ready() -> void:
	game_over_panel.hide()


func game_over() -> void:
	game_over_panel.show()


func set_score(score: int) -> void:
	score_label.text = "%s" % score
