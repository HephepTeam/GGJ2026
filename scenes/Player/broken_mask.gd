extends Node2D

signal finished

func _ready() -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "scale", Vector2.ONE * 10.0, 0.5)
	$AnimationPlayer.play("broken")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "broken":
		$AnimationPlayer.play("drift")
	else:
		finished.emit()
