extends CharacterBody2D
class_name Enemy

const SPEED := 200.0


@onready var body: AnimatedSprite2D = $Body

var colliding_areas: Array[Area2D] = []
var collision_vector := Vector2.ZERO

var health := 100.0
var attack := 8.0

var _body_direction := 1.0
var _prev_pos: Vector2


func _physics_process(delta: float) -> void:
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
	
	#if (global_position - _prev_pos).length() > 0.001:
		#_body_direction = sign(direction.x)
		#body.scale.x = _body_direction
	#
	#_prev_pos = global_position


func _on_area_2d_area_entered(area: Area2D) -> void:
	colliding_areas.append(area)


func _on_area_2d_area_exited(area: Area2D) -> void:
	colliding_areas.erase(area)
	
func get_damage(val: int):
	health -= val
	val = clamp(val , 0, health)
	if val == 0:
		queue_free()
		
func knockback(val: float):
	pass
	
