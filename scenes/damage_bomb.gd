extends Area2D

var data: ProjectileData

var grow_speed = 500.0

var _max_radius : float = 50.0
var _damage : float = 10.0

func _ready():
	if data:
		_max_radius = data.splash_radius
		_damage = data.power


func _physics_process(delta: float) -> void:
	$CollisionShape2D.shape.radius += delta * grow_speed
	
	if $CollisionShape2D.shape.radius >= _max_radius:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("get_damage"):
		area.get_parent().get_damage(_damage)
