extends Node

@onready var support_controller = $SupportController


func _ready():
	support_controller.spawn_supports(0)
	
