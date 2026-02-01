extends Node

signal room_entered(room)
signal mask_picked_up(d: MaskData)
signal camera_move_finished
signal crowbar_picked_up
signal healthbonus_picked_up

var kill_count := 0
var start_ticks := 0
var isDead = false

var entities_container: Node2D
var points_container: Node2D
var camera: Camera2D
var player: Player
var EnemyAround = []

var speed_multiplier := 1.0
var strength_multiplier := 1.0
var explosion_multiplier := 1.0

func _ready() -> void:
	mask_picked_up.connect(on_mask_picked_up)
	restart()


func restart() -> void:
	kill_count = 0
	start_ticks = Time.get_ticks_usec()

func launch_slowmo():
	camera.anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	camera.position += Vector2(512,512)
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.set_parallel(true)
	tween.tween_property(Engine, "time_scale", 0.2, 1.0)
	tween.tween_property(camera, "zoom", Vector2(2.0,2.0), 1.0)
	tween.tween_property(camera, "position", player.position, 1.0)
	await tween.finished

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
