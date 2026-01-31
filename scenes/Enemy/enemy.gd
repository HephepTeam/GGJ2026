extends CharacterBody2D
class_name Enemy

const SPEED := 200.0

var colliding_areas: Array[Area2D] = []
var collision_vector := Vector2.ZERO


func _physics_process(delta: float) -> void:
	var closest_player: Player = Globals.get_closest_player(global_position)
	if closest_player == null:
		return

	var direction := global_position.direction_to(
		closest_player.global_position
	)
	var new_collision_vector := Vector2.ZERO
	for colliding_area in colliding_areas:
		new_collision_vector += colliding_area.global_position.direction_to(global_position)
	collision_vector = lerp(collision_vector, new_collision_vector, 5.0 * delta)
	direction += collision_vector

	global_position += SPEED * delta * direction.normalized()


func _on_area_2d_area_entered(area: Area2D) -> void:
	colliding_areas.append(area)


func _on_area_2d_area_exited(area: Area2D) -> void:
	colliding_areas.erase(area)
