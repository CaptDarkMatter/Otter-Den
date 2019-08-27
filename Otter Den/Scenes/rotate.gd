extends Navigation2D

export(NodePath) var spritez
var path = []
var speed = 400.0

func _ready():
	pass

func _process(delta: float) -> void:
#	get_node(spritez).look_at(get_global_mouse_position())
	if path.size() == 0:
		return
	else:
		var move_distance = speed * delta
		move_along_path(move_distance)

func _draw():
	if path.size():
		for i in range(path.size()):
			draw_circle(path[i], 10, Color(1,1,1))

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 2:
			path = get_simple_path(get_node(spritez).position, event.position)
			update()

func move_along_path(distance : float) -> void:
	get_node(spritez).look_at(path[0])
	var start_pos = get_node(spritez).position
	for i in range(path.size()):
		var distance_to_next = start_pos.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			get_node(spritez).position = start_pos.linear_interpolate(path[0], distance / distance_to_next)
#			self.position = start_pos.lerp(path[0], distance / distance_to_next)
			break
		elif distance < 0.0:
			get_node(spritez).position = path[0]
			set_process(false)
			break
		distance -= distance_to_next
		start_pos = path[0]
		path.remove(0)