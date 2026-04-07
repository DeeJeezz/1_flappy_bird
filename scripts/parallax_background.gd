extends Parallax2D

var parallax_enabled: bool = false


#func _process(delta: float) -> void:
	#if parallax_enabled:
		#scroll_offset.x += autoscroll.x * delta
