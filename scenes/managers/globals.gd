extends Node

signal room_entered(room)
signal camera_move_finished

var EnemyAround = []

var current_cadence := 2.0
var current_power := 1.0
var current_range := 1.0

func get_enemy_around() -> Array[Enemy]:
	var enemies: Array[Enemy] = []
	enemies.append_array(get_tree().get_nodes_in_group("enemy"))
	return enemies


func get_players() -> Array[Player]:
	var players: Array[Player] = []
	players.append_array(get_tree().get_nodes_in_group("player"))
	return players


func get_closest_player(from_position: Vector2) -> Player:
	var min_distance := INF
	var closest: Player
	for player in get_players():
		var distance := from_position.distance_to(player.global_position)
		if distance < min_distance:
			min_distance = distance
			closest = player
	return closest
	
func on_mask_picked_up(data: MaskData):
	current_cadence += data.cadence_bonus
	current_power += data.power_bonus
	var p = get_players()[0]
	p.update_cadence(current_cadence)
	p.update_power(current_power)
	p.update_range(data.splash_bonus)
	p.update_mask(data.player_mask_texture)
