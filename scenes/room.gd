extends TileMapLayer

@export var enemy_scene: PackedScene
@export var enemy_mask_resource: MaskData
@export var max_enemies := 15

var count_enemies := 0


func _on_enter_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		Globals.room_entered.emit(self)


func _on_spawn_timer_timeout() -> void:
	if count_enemies > max_enemies:
		%SpawnTimer.stop()
		return
	var enemy: Enemy = enemy_scene.instantiate()
	%Spawned.add_child.call_deferred(enemy)
	enemy.mask = enemy_mask_resource
	%PathFollow2D.progress_ratio = randf()
	enemy.set_deferred('global_position', %PathFollow2D.global_position)
	count_enemies += 1
