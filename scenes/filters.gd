extends ColorRect


func _ready() -> void:
	Globals.mask_picked_up.connect(on_mask_picked_up)

func on_mask_picked_up(_mask_data: MaskData) -> void:
	material.set_shader_parameter("speed", clamp(Globals.speed_multiplier - 1.0, 0.0, 1.0))
	material.set_shader_parameter("strength", clamp(Globals.strength_multiplier - 1.0, 0.0, 1.0))
	material.set_shader_parameter("explosion", clamp(Globals.explosion_multiplier - 1.0, 0.0, 1.0))
