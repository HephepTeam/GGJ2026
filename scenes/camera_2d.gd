extends Camera2D

var tween : Tween

func _ready():
	Globals.room_entered.connect(update_camera)


func update_camera(room):
	if tween: tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "global_position", room.global_position, 0.7)
	
	tween.tween_callback(_on_anim_finished)
	
func _on_anim_finished():
	Globals.camera_move_finished.emit()
