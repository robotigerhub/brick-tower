extends Node

@export var support_scene: PackedScene

var a = 500
var l = 18
var positions = {
	0: {
		"x": [a - l*2, a - l*1, a + l*0, a + l+1, a + l*2],
		"y": [a - l*2, a - l*1, a + l*0, a + l+1, a + l*2]
	},
	1: {
		"x": [a - l*3, a - l*2, a - l*1, a + l*0, a + l*1, a + l*2, a + l*3],
		"y": [a - l*3, a - l*4, a - l*5, a - l*6, a - l*7]
	}
}
var counts = [5, 4]


func spawn_supports(level: int):
	for i in counts[level]:
		var support = support_scene.instantiate()
		add_child(support)
		support.global_position = Vector2(positions[level]["x"].pick_random(), positions[level]["y"].pick_random())
