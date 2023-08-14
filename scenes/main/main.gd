extends Node

@onready var spawn_position = $SpawnPosition
@onready var move_timer = $MoveTimer

@export var blocks: Array[PackedScene]

var current_block = null
var can_move = true


func _ready():
	await get_tree().create_timer(5).timeout
	for i in 5:
		current_block = spawn_block()
		await current_block.body_entered
		current_block.gravity_scale = 1


func _process(_delta):
	if not can_move:
		return
	
	if Input.is_action_pressed("left"):
		current_block.move_left()
	elif Input.is_action_pressed("right"):
		current_block.move_right()
	elif Input.is_action_pressed("down"):
		current_block.move_down()
	
	await_move_timer()


func await_move_timer():
	can_move = false
	move_timer.start()
	await move_timer.timeout
	can_move = true


func spawn_block():
	var block = blocks.pick_random().instantiate() as RigidBody2D
	call_deferred("add_child", block)
	block.global_position = spawn_position.global_position
	return block
