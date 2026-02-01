extends Node

signal room_entered(room)
signal mask_picked_up(d: MaskData)
signal camera_move_finished
signal crowbar_picked_up
signal healthbonus_picked_up
signal filters_changed

const SPEED_INCREMENT := 0.1
const STRENGTH_INCREMENT := 0.1
const EXPLOSION_INCREMENT := 0.1

var kill_count := 0
var start_ticks := 0
var isDead = false

var entities_container: Node2D
var points_container: Node2D
var camera: Camera2D
var player: Player
var EnemyAround = []
var maskTab = []

var speed_multiplier := 1.0:
	set(value):
		speed_multiplier = value
		filters_changed.emit()
var strength_multiplier := 1.0:
	set(value):
		strength_multiplier = value
		filters_changed.emit()
var explosion_multiplier := 1.0:
	set(value):
		explosion_multiplier = value
		filters_changed.emit()


func _ready() -> void:
	mask_picked_up.connect(on_mask_picked_up)
	restart()


func restart() -> void:
	kill_count = 0
	start_ticks = Time.get_ticks_usec()

func game_over_effects():
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(Engine, "time_scale", 0.2, 0.5)
	tween.tween_property(self, "speed_multiplier", 0.0, 0.3)
	tween.tween_property(self, "strength_multiplier", 0.0, 0.3)
	tween.tween_property(self, "explosion_multiplier", 0.0, 0.3)

func get_elapsed_time() -> float:
	return (Time.get_ticks_usec() - start_ticks) / 1_000_000.0


func get_enemy_around():
	var enemies:  = []
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
	speed_multiplier += data.speed_bonus
	strength_multiplier += data.strength_bonus
	explosion_multiplier += data.explosion_bonus
	var p = get_players()[0]
	p.update_bonuses()
	p.update_mask(data.player_mask_texture)
	maskTab.append(data.player_mask_texture)
	filters_changed.emit()
