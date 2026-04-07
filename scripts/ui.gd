extends CanvasLayer
class_name UI

@export var game_over_panel: Panel
@export var start_game_panel: Panel
@export var score_label: Label
@export var session_score_label: Label
@export var last_score_label: Label


func _ready() -> void:
	start_game_panel.show()
	game_over_panel.hide()


func game_over(score: int) -> void:
	game_over_panel.show()
	score_label.hide()
	session_score_label.text = "Current score: %s" % score


func set_score(score: int) -> void:
	score_label.text = "%s" % score
	
	
func set_last_score(score: int) -> void:
	last_score_label.text = "Last score: %s" % score


func game_started() -> void:
	start_game_panel.hide()


func _on_restart_button_button_down() -> void:
	Signals.restart_game.emit()
