extends Area2D

const BASE_RADIUS := Vector2.ONE * 75.0
const BASE_DAMAGE := 25.0

var data: ProjectileData:
	set(value):
		data = value
		_max_radius = data.splash_radius * BASE_RADIUS
		_damage = data.power * BASE_DAMAGE

var grow_speed = 500.0

var _max_radius := Vector2.ONE * BASE_RADIUS
var _damage : float = 10.0


func _physics_process(delta: float) -> void:
	scale += Vector2.ONE * delta * grow_speed
	
	if scale >= _max_radius:
		var tween := create_tween()
		tween.tween_property(self, "scale", Vector2.ZERO, 0.1)
		tween.tween_callback(queue_free)


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("get_damage"):
		area.get_parent().get_damage(_damage)
