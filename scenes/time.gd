extends Label


func _ready() -> void:
	update_time()
	if Globals.player != null:
		Globals.player.dead.connect($Timer.stop)

func update_time() -> void:
	text = '%.0f' % Globals.get_elapsed_time()

func _on_timer_timeout() -> void:
	update_time()
