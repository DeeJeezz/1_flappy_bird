extends Area2D
class_name ScoreArea


@onready var sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _on_body_entered(body: Node2D) -> void:
	Signals.obstacle_passed.emit()
	sfx.play()
