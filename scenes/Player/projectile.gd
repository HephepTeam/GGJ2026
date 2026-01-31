extends Area2D
class_name Projectile

var direction : Vector2
var speed : float = 200.0

func _ready():
	pass
	
	
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
