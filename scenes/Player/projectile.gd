extends Area2D
class_name Projectile

var data: ProjectileData

signal touched(pos: Vector2)

var direction : Vector2
var speed : float = 200.0
	
	
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	touched.emit(global_position)
	queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	touched.emit(global_position)
	queue_free()
