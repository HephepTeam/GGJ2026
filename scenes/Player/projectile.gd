extends Area2D
class_name Projectile

var data: ProjectileData

var direction : Vector2
var speed : float = 200.0
	
	
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
