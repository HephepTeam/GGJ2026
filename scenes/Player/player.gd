extends CharacterBody2D
class_name Player

signal dead

const MAX_HEALTH = 100.0

@export var projectile_scene: PackedScene
@export var damage_bomb_scene : PackedScene

@export var speed := 500.0
@export var health := 100.0
@export var cooldown_hit_duration := 1.0

@onready var cooldown_hit: Timer = $CooldownHit
@onready var cooldown_shoot: Timer = $CooldownShoot
@onready var body: AnimatedSprite2D = $Body
@onready var shoot_point: Marker2D = $Body/Mask/ShootPoint

@export var projectile_data : ProjectileData

var body_direction = 1.0
var _cooldown_hit = false

var knockback_dir : Vector2
var knockback_force := 200.0

func set_data(data: MaskData):
	update_cadence(data.cadence_bonus)

func _physics_process(delta):
	var direction = Input.get_vector(
		'ui_left', 'ui_right', 'ui_up', 'ui_down')

	if direction.length():
		velocity = velocity.lerp(direction * speed, delta * 12.0)

		$Body.play("run")
		if abs(velocity.x) > 0.01: 
			body_direction = sign(velocity.x)
			body.scale.x = body_direction
			skew = lerp(skew, deg_to_rad(body_direction*12.0), delta*80)
			
	else:
		$Body.play("idle")
		skew = lerp(skew, 0.0, delta*80)
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	velocity += -knockback_dir
	knockback_dir = knockback_dir.lerp(Vector2.ZERO, delta * 5.0)
	move_and_slide()

func _process(delta: float) -> void:
	if health < MAX_HEALTH:
		$healthbar.show()
		$healthbar.value = health

func update_cadence(new_cadence: float):
	$CooldownShoot.wait_time = 1.0 / new_cadence

func update_power(new_power: float):
	projectile_data.power = new_power
	
func update_range(new_range: float):
	projectile_data.splash_radius = new_range
	
func update_mask(new_mask: Texture):
	$Body/Mask.texture = new_mask
	
	

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
	inst.touched.connect(_on_projectile_touched)

	
func get_damage(val: int, dir: Vector2):
	if !_cooldown_hit:
		_cooldown_hit = true
		knockback_dir = dir * knockback_force
		health -= val
		anim_hit()
		val = clamp(val , 0, MAX_HEALTH)
		cooldown_hit.start(cooldown_hit_duration)
		if val == 0:
			dead.emit()
			
			
func anim_hit():
	$Body.modulate.v = 1500.0
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($Body, "modulate:v", 1.0, 0.3)


func _on_timer_timeout() -> void:
	var target = _check_for_nearest_enemy()
	if target:
		shoot(target.global_position)
	
	
func _on_projectile_touched(pos: Vector2):
	var inst = damage_bomb_scene.instantiate()
	#inst.data = projectile_data
	add_sibling.call_deferred(inst)
	inst.set_deferred("global_position", pos)

	


func _on_cooldown_hit_timeout() -> void:
	_cooldown_hit = false


func _on_repulse_area_entered(area: Area2D) -> void:
	get_damage(area.get_parent().attack, (area.get_parent().global_position-global_position).normalized())
	pass
