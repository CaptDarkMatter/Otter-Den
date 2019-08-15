extends Navigation2D

#var path = []
#var touchpos = Vector2(0,0)

func _ready():
	set_process_input(true)

func _create_path(var start, var end):
	var newPath = get_simple_path(start, end)
	return newPath

#func _draw():
#	if path.size():
#		for i in range(path.size()):
#			draw_circle(path[i], 10, Color(1,1,1))

#func _unhandled_input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == 2:
#			path = get_simple_path(get_node("NavigationPolygonInstance/FrogSprite").position, event.position)
#			update()
#	pass

