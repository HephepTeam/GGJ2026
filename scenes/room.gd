extends TileMapLayer

@export var enemy_scene: PackedScene
@export var enemy_mask_resource: MaskData
@export var max_enemies := 15

@onready var doors_collision: StaticBody2D = $DoorsCollision
@onready var spawn_timer: Timer = %SpawnTimer
@onready var doors: Node2D = $Doors

@export_flags("North","South","East","West",)
var door_flags = 0

var count_enemies := 0
var killed_enemies:= 0

func _ready():
	print(door_flags)

	if door_flags & 1 == 1:
		set_cell(Vector2i(7,0), 3, Vector2.ZERO)
		set_cell(Vector2i(8,0), 3, Vector2.ZERO)
	if door_flags & 2 == 2:
		set_cell(Vector2i(7,15), 3, Vector2.ZERO)
		set_cell(Vector2i(8,15), 3, Vector2.ZERO)
	if door_flags & 4 == 4:
		set_cell(Vector2i(15,7), 3, Vector2.ZERO)
		set_cell(Vector2i(15,8), 3, Vector2.ZERO)
	if door_flags & 8 == 8:
		set_cell(Vector2i(0,7), 3, Vector2.ZERO)
		set_cell(Vector2i(0,8), 3, Vector2.ZERO)
			
	open_doors()


func _on_enter_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		Globals.room_entered.emit(self)
		await Globals.camera_move_finished
		spawn_timer.start()
		close_doors()
		

func close_doors():
	doors_collision.set_collision_layer_value(4, true)

	if door_flags & 1 == 1:
			$Doors/doorN.play("closed")
	if door_flags & 2 == 2:
			$Doors/doorS.play("closed")
	if door_flags & 4 == 4:
			$Doors/doorE.play("closed")
	if door_flags & 8 == 8:
			$Doors/doorW.play("closed")
			
func open_doors():
	doors_collision.set_collision_layer_value(4, false)

	if door_flags & 1 == 1:
			$Doors/doorN.play("open")
	if door_flags & 2 == 2:
			$Doors/doorS.play("open")
	if door_flags & 4 == 4:
			$Doors/doorE.play("open")
	if door_flags & 8 == 8:
			$Doors/doorW.play("open")


func _on_spawn_timer_timeout() -> void:
	if count_enemies >= max_enemies:
		%SpawnTimer.stop()
		return
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.died.connect(_on_enemy_killed)
	%Spawned.add_child.call_deferred(enemy)
	enemy.mask = enemy_mask_resource
	%PathFollow2D.progress_ratio = randf()
	enemy.set_deferred('global_position', %PathFollow2D.global_position)
	count_enemies += 1
	
	
func _on_enemy_killed():
	killed_enemies+=1
	if killed_enemies == max_enemies:
		await get_tree().create_timer(1.0).timeout
		open_doors()
