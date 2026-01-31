extends Label
class_name Points


func _ready() -> void:
	var tween := create_tween()
	tween.set_parallel()
	tween.tween_property(self, 'position:y', -50.0, 0.5).as_relative()
	tween.tween_property(self, 'modulate:a', 0.0, 0.5)
	await tween.finished
	queue_free()
