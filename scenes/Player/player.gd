extends CharacterBody2D
class_name Player

signal dead

const MAX_HEALTH = 500.0

@export var projectile_scene: PackedScene

@export var speed = 400.0
@export var health = 100.0

@onready var body: AnimatedSprite2D = $Body
@onready var shoot_point: Marker2D = $Body/Mask/ShootPoint

@export var projectile_data : ProjectileData
@export var shoot_rate := 1.0

var body_direction = 1.0

func _ready():
	$Timer.start(shoot_rate)

func _physics_process(delta):
	var direction = Input.get_vector(
		'ui_left', 'ui_right', 'ui_up', 'ui_down')

	if direction.length():
		velocity = direction * speed
		if abs(velocity.x) > 0.01: 
			
			body_direction = sign(velocity.x)
			skew = lerp(skew, deg_to_rad(body_direction*12.0), delta*80)
			body.scale.x = body_direction
	else:
		skew = lerp(skew, 0.0, delta*80)
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()

func update_cadence(new_cadence: float):
	shoot_rate = 60.0 / new_cadence
	
	

func _check_for_nearest_enemy() -> Enemy:
	var enemies = Globals.get_enemy_around()
	var min_distance := INF
	var nearest = null
	for enemy in enemies:
		var distance = (enemy.global_position - global_position).length()
		if min_distance > distance:
			min_distance = distance
			nearest = enemy
	return nearest
	
func shoot(target: Vector2):
	var inst = projectile_scene.instantiate()
	var dir = (target - global_position).normalized()
	inst.direction = dir
	inst.data = projectile_data
	get_parent().add_child(inst)
	inst.global_position = shoot_point.global_position

	
func get_damage(val: int):
	health -= val
	val = clamp(val , 0, MAX_HEALTH)
	if val == 0:
		dead.emit()


func _on_timer_timeout() -> void:
	var target = _check_for_nearest_enemy()
	if target:
		shoot(target.global_position)
	
	$Timer.start(shoot_rate)
