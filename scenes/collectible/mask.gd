extends Area2D
class_name Mask

@export var data: MaskData

var tween: Tween

@onready var mask_sprite: Sprite2D = $MaskSprite
@onready var init_pos_y = $MaskSprite.position.y

func _ready():
	if data:
		mask_sprite.texture = data.mask_texture
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.set_loops(0)
	tween.tween_property($MaskSprite, "position:y", init_pos_y-20.0, 0.7)
	tween.tween_property($MaskSprite, "position:y", init_pos_y, 0.7)


func _on_body_entered(body: Node2D) -> void:
	Globals.mask_picked_up.emit(data)
	if tween: tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.set_parallel(true)
	tween.tween_property($MaskSprite, "position:y", -60.0, 0.2).as_relative()
	tween.tween_property($MaskSprite, "scale:x", 0.0, 0.3)
	tween.set_parallel(false)
	tween.tween_callback(queue_free)
