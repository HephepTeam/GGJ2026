extends ColorRect


var player: Player


func _ready() -> void:
	Globals.mask_picked_up.connect(on_mask_picked_up)
	var players := Globals.get_players()
	if len(players) > 0:
		player = players[0]

func _process(_delta: float) -> void:
	if player != null:
		material.set_shader_parameter(
			"player_position", player.global_position - Globals.camera.global_position
		)


func on_mask_picked_up(_mask_data: MaskData) -> void:
	material.set_shader_parameter("speed", clamp(Globals.speed_multiplier - 1.0, 0.0, 1.0))
	material.set_shader_parameter("strength", clamp(Globals.strength_multiplier - 1.0, 0.0, 1.0))
	material.set_shader_parameter("explosion", clamp(Globals.explosion_multiplier - 1.0, 0.0, 1.0))
