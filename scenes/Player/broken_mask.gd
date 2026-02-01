extends Node2D


func _ready() -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "scale", Vector2.ONE, 0.3)
	await tween.finished
	$AnimationPlayer.play("broken")
