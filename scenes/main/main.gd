extends Node

@export var blocks: Array[PackedScene]

var current_block = null


func _ready():
	await get_tree().create_timer(5).timeout
	for i in 5:
		current_block = spawn_block()
		await current_block.body_entered


func spawn_block():
	var block = blocks.pick_random().instantiate()
	call_deferred("add_child", block)
	block.global_position = Vector2(518, 50)
	return block