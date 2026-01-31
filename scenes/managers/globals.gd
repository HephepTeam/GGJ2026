extends Node


var EnemyAround = []

func get_enemy_around():
	EnemyAround = get_tree().get_nodes_in_group("enemy")
	return EnemyAround
