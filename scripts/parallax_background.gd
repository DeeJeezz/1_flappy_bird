extends Parallax2D


func _process(delta: float) -> void:
	scroll_offset.x += autoscroll.x * delta
