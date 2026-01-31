extends Area2D

var data: ProjectileData

var grow_speed = 500.0

var _max_radius := Vector2.ONE * 75.0
var _damage : float = 10.0

func _ready():
	if data:
		_max_radius = Vector2.ONE * data.splash_radius
		_damage = data.power


func _physics_process(delta: float) -> void:
	scale += Vector2.ONE * delta * grow_speed
	
	if scale >= _max_radius:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("get_damage"):
		area.get_parent().get_damage(_damage)
