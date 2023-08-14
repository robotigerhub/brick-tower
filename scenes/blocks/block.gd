extends RigidBody2D


func _ready():
	modulate = Color(randf(), randf(), randf())
	gravity_scale = 0


func move_left():
	move(Vector2(-9, 0))


func move_right():
	move(Vector2(9, 0))


func move_down():
	move(Vector2(0, 9))


func move(vector: Vector2):
	global_position += vector
