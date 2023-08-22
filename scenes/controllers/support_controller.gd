extends Node

@export var support_scene: PackedScene

var positions = {
	0: {
		"x": [500, 518, 536, 554, 572, 590],
		"y": [500, 518, 536, 554, 572, 590]
	}
}


func _ready():
	for i in 8:
		spawn_support()


func spawn_support():
	var support = support_scene.instantiate()
	add_child(support)
	support.global_position = Vector2(positions[0]["x"].pick_random(), positions[0]["y"].pick_random())
