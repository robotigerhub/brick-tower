extends RigidBody2D
class_name Block

signal landed

const SLOW_SPEED = 60
const FAST_SPEED = SLOW_SPEED * 3

var speed = SLOW_SPEED
var first_contact = true


func go_slow():
	speed = SLOW_SPEED


func go_fast():
	speed = FAST_SPEED


func move_left():
	move(Vector2(-9, 0))


func move_right():
	move(Vector2(9, 0))


func move_down(delta: float):
	move(Vector2(0, speed * delta))


func move(vector: Vector2):
	global_position += vector


func rotate_block():
	rotate(PI/2)


func _on_body_entered(_body):
	if first_contact:
		gravity_scale = 1
		landed.emit()
		first_contact = false
		set_deferred("contact_monitor", false)
