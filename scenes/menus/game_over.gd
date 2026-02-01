extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property($ColorRect, "modulate:a", 0.0, 1.3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event):
	if event.is_action_pressed("ui_accept"):
		print("Je Passe")
		get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
