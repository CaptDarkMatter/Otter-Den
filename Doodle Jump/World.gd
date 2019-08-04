extends Node2D

var platform = preload("res://Platform.tscn")

func _ready():
	#dim = get_viewport().size.x
	randomize()
	var y = 800
	while y > -3000:
		var newPlatform = platform.instance()
		newPlatform.position = Vector2(rand_range(0,560), y)
		add_child(newPlatform)
		y -= rand_range(0, 210)
	pass
