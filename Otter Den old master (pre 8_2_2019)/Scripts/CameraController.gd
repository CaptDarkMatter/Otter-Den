extends Camera2D
export(float) var max_zoom = 4.0
export(float) var min_zoom = 0.25
export(NodePath) var shipPath

var touchStart
var ship

func _ready():
	set_process_input(true)
	set_process(true)
	ship = get_node(shipPath)
	self.position = ship.position
	pass
	
func _input(event):
	var key_str = ""
	if event is InputEventMouseButton:
		touchStart = get_viewport().get_mouse_position()
		#get_global_mouse_position() or get_camera_screen_center() might help fix this problem
	
	# Wheel Up Event
	if event.is_action_pressed("zoom_in") or key_str == '+':
		#print(event.position)
		_zoom_camera(-1)
		# Wheel Down Event
	elif event.is_action_pressed("zoom_out") or key_str == '-':
		_zoom_camera(1)
	pass
	
func _process(delta):
	if Input.is_action_pressed("mouse_left"):
		var direction = touchStart - get_viewport().get_mouse_position()
		self.position += direction
		
	pass

# Zoom Camera
func _zoom_camera(dir):
	zoom += Vector2(0.1, 0.1) * dir
	zoom.x = clamp(zoom.x, min_zoom, max_zoom)
	zoom.y = clamp(zoom.y, min_zoom, max_zoom)