extends Node

signal room_entered(room)

var EnemyAround = []

func get_enemy_around():
	EnemyAround = get_tree().get_nodes_in_group("enemy")
	return EnemyAround
