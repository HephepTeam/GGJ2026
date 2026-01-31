extends Label


func _on_timer_timeout() -> void:
	text = '%.0f' % Globals.get_elapsed_time()
