extends ColorRect


var player: Player

var speed := 0.0:
	set(value):
		speed = value
		material.set_shader_parameter("speed", value)
var strength := 0.0:
	set(value):
		strength = value
		material.set_shader_parameter("strength", value)
var explosion := 0.0:
	set(value):
		explosion = value
		material.set_shader_parameter("explosion", value)


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
	var new_speed := clampf(Globals.speed_multiplier - 1.0, 0.0, 1.0)
	var new_strength := clampf(Globals.strength_multiplier - 1.0, 0.0, 1.0)
	var new_explosion := clampf(Globals.explosion_multiplier - 1.0, 0.0, 1.0)
	if abs(new_speed - speed) > 0.0001:
		var tween := create_tween()
		tween.tween_property(self, "speed", 1.0, 0.2)
		tween.tween_property(self, "speed", new_speed, 0.2)

	if abs(new_strength - strength) > 0.0001:
		var tween := create_tween()
		tween.tween_property(self, "strength", 1.0, 0.2)
		tween.tween_property(self, "strength", new_strength, 0.2)

	if abs(new_explosion - explosion) > 0.0001:
		var tween := create_tween()
		tween.tween_property(self, "explosion", 1.0, 0.2)
		tween.tween_property(self, "explosion", new_explosion, 0.2)
