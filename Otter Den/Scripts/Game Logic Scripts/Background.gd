extends Node2D

export(NodePath) var water
export(NodePath) var water2

func _ready():
	pass

func _process(delta):
	get_node(water).position += Vector2(0,0.2)
	get_node(water2).position += Vector2(0,0.2)

	if get_node(water).position.y >= 3540:
		get_node(water).position.y = -3540

	if get_node(water2).position.y >= 3540:
		get_node(water2).position.y = -3540