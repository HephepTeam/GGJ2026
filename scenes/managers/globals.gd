extends Node

signal room_entered(room)

var EnemyAround = []

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
