extends CharacterBody2D
class_name Player

signal dead

const MAX_HEALTH = 100.0

var points_scene: PackedScene = preload("res://scenes/points.tscn")

@export var projectile_scene: PackedScene
@export var damage_bomb_scene : PackedScene
@export var broken_mask_scene: PackedScene

@export var speed := 500.0
@export var health := 100.0
@export var cooldown_hit_duration := 1.0

@onready var cooldown_hit: Timer = $CooldownHit
@onready var cooldown_shoot: Timer = $CooldownShoot
@onready var body: AnimatedSprite2D = %Body
@onready var shoot_point: Marker2D = %ShootPoint

@export var projectile_data : ProjectileData


var is_dead := false

var body_direction = 1.0
var _cooldown_hit = false

var knockback_dir : Vector2
var knockback_force := 200.0

func _ready() -> void:
	Globals.player = self

func _physics_process(delta):
	if !is_dead:
		var direction = Input.get_vector(
			'ui_left', 'ui_right', 'ui_up', 'ui_down')

		if direction.length():
			velocity = velocity.lerp(direction * speed, delta * 12.0)

			%Body.play("run")
			if abs(velocity.x) > 0.01:
				body_direction = sign(velocity.x)
				body.scale.x = body_direction
				%Visuals.skew = lerp(%Visuals.skew, deg_to_rad(body_direction*12.0), delta*80)

		else:
			%Body.play("idle")
			%Visuals.skew = lerp(%Visuals.skew, 0.0, delta*80)
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)

		velocity += -knockback_dir
		knockback_dir = knockback_dir.lerp(Vector2.ZERO, delta * 5.0)
		move_and_slide()

func _process(delta: float) -> void:
	if health < MAX_HEALTH:
		$healthbar.show()
		$healthbar.value = health

func update_bonuses():
	$CooldownShoot.wait_time = 1.0 / Globals.speed_multiplier
	projectile_data.power = Globals.strength_multiplier
	projectile_data.splash_radius = Globals.explosion_multiplier

func update_mask(new_mask: Texture):
	%Mask.texture = new_mask


func _check_for_nearest_enemy() -> Enemy:
	var enemies = Globals.get_enemy_around()
	var min_distance := INF
	var nearest = null
	for enemy in enemies:
		var distance = enemy.global_position.distance_squared_to(global_position)
		if min_distance > distance:
			min_distance = distance
			nearest = enemy
	return nearest

func shoot(target: Vector2):
	if !is_dead:
		var inst = projectile_scene.instantiate()
		var dir = (target - global_position).normalized()
		inst.direction = dir
		inst.data = projectile_data
		Globals.entities_container.add_child(inst)
		inst.global_position = shoot_point.global_position
		inst.touched.connect(_on_projectile_touched)


func add_damage_points(damage: float) -> void:
	var points: Points = points_scene.instantiate()
	points.text = '%d' % damage
	points.modulate = Color(1.0, 0.0, 0.0, 1.0)
	Globals.points_container.add_child.call_deferred(points)
	points.set_deferred('global_position', global_position - Vector2(0.0, 64.0))


func get_damage(val: int, dir: Vector2):
	if !_cooldown_hit and !is_dead:
		_cooldown_hit = true
		knockback_dir = dir * knockback_force
		health = clamp(health - val, 0.0, MAX_HEALTH)
		anim_hit()
		add_damage_points(val)
		cooldown_hit.start(cooldown_hit_duration)
		if health <= 0:
			body.play("idle")
			is_dead = true
			var inst = broken_mask_scene.instantiate()
			add_child(inst)
			inst.position = shoot_point.position
			Globals.launch_slowmo()
			dead.emit()


func anim_hit():
	%Body.modulate.v = 1500.0
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(%Body, "modulate:v", 1.0, 0.3)


func _on_timer_timeout() -> void:
	var target = _check_for_nearest_enemy()
	if target:
		shoot(target.global_position)


func _on_projectile_touched(pos: Vector2):
	var inst = damage_bomb_scene.instantiate()
	inst.data = projectile_data
	add_sibling.call_deferred(inst)
	inst.set_deferred("global_position", pos)


func _on_cooldown_hit_timeout() -> void:
	_cooldown_hit = false


func _on_repulse_area_entered(area: Area2D) -> void:
	get_damage(area.get_parent().attack, (area.get_parent().global_position-global_position).normalized())
	pass


func _on_light_speed_change_timer_timeout() -> void:
	%LightAnimationPlayer.speed_scale = randf_range(0.3, 1.0)
