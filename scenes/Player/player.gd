extends CharacterBody2D
class_name Player

@export var speed = 400.0
@export var health = 100.0

func _physics_process(_delta):
	var direction = Input.get_vector(
		'ui_left', 'ui_right', 'ui_up', 'ui_down')

	if direction.length():
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
