extends Node

@export var support_scene: PackedScene

var a = 500
var l = 18
var positions = {
	0: {
		"x": [-2, 2],
		"y": [-2, 2]
	},
	1: {
		"x": [-3, 3],
		"y": [-3, -7]
	}
}
var counts = [5, 4]


func spawn_supports(level: int):
	for i in counts[level]:
		var support = support_scene.instantiate()
		add_child(support)
		var x_from = positions[level]["x"][0]
		var x_to = positions[level]["x"][1]
		var y_from = positions[level]["y"][0]
		var y_to = positions[level]["y"][1]
		support.global_position = Vector2(a + l*randi_range(x_from, x_to), a + l*randi_range(y_from, y_to))
