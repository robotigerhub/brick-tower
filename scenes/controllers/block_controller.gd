extends Node

@export var play_position: Node2D
@export var preview_position: Node2D
@onready var move_timer = $MoveTimer
@onready var start_timer = $StartTimer

@export var blocks: Array[PackedScene]

var current_block: Block = null
var next_block: Block = null
var can_move_sideways = true
var blocks_to_go = 10


func _ready():
	get_new_next_block()
	start_timer.start()


func _process(delta):
	handle_input(delta)


func handle_input(delta):
	if not current_block:
		return
	
	if Input.is_action_just_pressed("rotate"):
		current_block.rotate_block()

	if Input.is_action_pressed("down"):
		current_block.go_fast()
	else:
		current_block.go_slow()
	current_block.move_down(delta)
	
	if can_move_sideways:
		if Input.is_action_pressed("left"):
			current_block.move_left()
		elif Input.is_action_pressed("right"):
			current_block.move_right()
		prevent_side_movement()


func prevent_side_movement():
	can_move_sideways = false
	move_timer.start()


func play_block():
	next_block.landed.connect(_on_current_block_landed)
	next_block.global_position = play_position.global_position
	current_block = next_block
	
	if blocks_to_go > 0:
		get_new_next_block()
	else:
		next_block = null


func get_new_next_block():
	next_block = blocks.pick_random().instantiate() as Block
	
	await get_tree().process_frame
	add_child(next_block)
	next_block.global_position = preview_position.global_position
	blocks_to_go -= 1


func _on_current_block_landed():
	if next_block:
		play_block()
	else:
		current_block = null


func _on_move_timer_timeout():
	can_move_sideways = true


func _on_start_timer_timeout():
	play_block()
