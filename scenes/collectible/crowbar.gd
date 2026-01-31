extends Area2D
class_name Crowbar

var tween: Tween
@onready var crowbar_sprite: Sprite2D = $CrowbarSprite

@onready var init_pos_y = crowbar_sprite.position.y

func _ready():
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.set_loops(0)
	tween.tween_property(crowbar_sprite, "position:y", init_pos_y-20.0, 0.7)
	tween.tween_property(crowbar_sprite, "position:y", init_pos_y, 0.7)


func _on_body_entered(body: Node2D) -> void:
	Globals.crowbar_picked_up.emit()
	if tween: tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.set_parallel(true)
	tween.tween_property(crowbar_sprite, "position:y", -60.0, 0.2).as_relative()
	tween.tween_property(crowbar_sprite, "scale:x", 0.0, 0.3)
	tween.set_parallel(false)
	tween.tween_callback(queue_free)
