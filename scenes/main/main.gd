extends Node

@onready var spawn_position = $SpawnPosition
@onready var move_timer = $MoveTimer

@export var blocks: Array[PackedScene]

var current_block = null
var can_move = true


func _ready():
	await get_tree().create_timer(3).timeout
	for i in 18:
		current_block = spawn_block()
		await current_block.body_entered
		current_block.gravity_scale = 1
	current_block = null


func _process(delta):
	if not current_block:
		return
	
	if Input.is_action_just_pressed("rotate"):
		current_block.rotate_block()

	if Input.is_action_pressed("down"):
		current_block.go_fast()
	else:
		current_block.go_slow()
	current_block.move_down(delta)
	
	if can_move:
		if Input.is_action_pressed("left"):
			current_block.move_left()
		elif Input.is_action_pressed("right"):
			current_block.move_right()
		await_move_timer()


func await_move_timer():
	can_move = false
	move_timer.start()
	await move_timer.timeout
	can_move = true


func spawn_block():
	var block = blocks.pick_random().instantiate() as Block
	call_deferred("add_child", block)
	block.global_position = spawn_position.global_position
	return block
