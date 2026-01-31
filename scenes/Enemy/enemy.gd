extends CharacterBody2D
class_name Enemy

const SPEED := 200.0
const DROP_PROBABILITY := 0.1

@export var mask: MaskData

@onready var body: AnimatedSprite2D = $Body

var mask_scene: PackedScene = preload("res://scenes/collectible/mask.tscn")
var colliding_areas: Array[Area2D] = []
var collision_vector := Vector2.ZERO

const base_health = 100.0
var health := 100.0
var attack := 16.0

var _body_direction := 1.0
var _prev_pos: Vector2

func _ready():
	Globals.mask_picked_up.connect(on_mask_picked_up)
	if mask:
		$Body/Mask.texture = mask.mask_texture
	change_modulate()

func is_dead() -> bool:
	return health <= 0

func _physics_process(delta: float) -> void:
	if is_dead():
		return

	var closest_player: Player = Globals.get_closest_player(global_position)
	if closest_player == null:
		return

	var direction := global_position.direction_to(
		closest_player.global_position
	)
	var new_collision_vector := Vector2.ZERO
	for colliding_area in colliding_areas:
		var knockback_dir = colliding_area.global_position.direction_to(global_position)
		if colliding_area.get_collision_layer_value(7):
			knockback_dir *= 6.0
		new_collision_vector += knockback_dir
	collision_vector = lerp(collision_vector, new_collision_vector, 5.0 * delta)
	direction += collision_vector

	global_position += SPEED * delta * direction.normalized()
	#_prev_pos = global_position

	move_and_slide()


	_body_direction = sign(direction.x)
	body.scale.x = _body_direction

	_prev_pos = global_position

func _process(delta: float) -> void:
	if health < base_health:
		$healthbar.show()
		$healthbar.value = health

func _on_area_2d_area_entered(area: Area2D) -> void:
	colliding_areas.append(area)


func _on_area_2d_area_exited(area: Area2D) -> void:
	colliding_areas.erase(area)

func die() -> void:
	if randf() < DROP_PROBABILITY:
		var dropped_mask: Mask = mask_scene.instantiate()
		dropped_mask.data = mask
		Globals.entities_container.add_child.call_deferred(
			dropped_mask
		)
		dropped_mask.set_deferred('global_position', global_position)

	queue_free()

func get_damage(val: int):
	health = clamp(health - val, 0, health)
	var tween := create_tween()
	tween.tween_property(%Body, 'modulate:v', 15.0, 0.1)
	tween.tween_property(%Body, 'modulate:v', 1.0, 0.1)
	if health <= 0:
		tween.tween_property(%Body, 'scale:y', 0.0, 0.3)
		tween.tween_callback(die)


func knockback(val: float):
	pass


func change_modulate() -> void:
	var non_red_attenuation := clampf(1.0 - (Globals.strength_multiplier - 1.0), 0.0, 1.0)
	modulate.g = non_red_attenuation
	modulate.b = non_red_attenuation
	modulate.a = non_red_attenuation

func on_mask_picked_up(_mask_data: MaskData) -> void:
	change_modulate()
