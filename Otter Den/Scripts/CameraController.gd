extends Node

var touchStart
export var zoomOutMin = 1
export var zoomOutMax = 8

func _ready():
	set_process_input(true)
	set_process(true)
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		touchStart = get_viewport().get_mouse_position()
	pass
	
func _process(delta):
	if Input.is_action_pressed("mouse_left"):
		var direction = touchStart - get_viewport().get_mouse_position()
		self.position += direction
	pass
	
func _zoom(var increment):
	return increment
	
#	This is all psedo-code for the Camera Script imported from Unity. Use this as an example for remaking in Godot.
	#Vector2 touchStart //this is the point in space where you first put your finger to move.
#	void update //this could be one of two things in godot. either the _process func or _input. still dont know yet.
# 	if(Input.GetMouseButtonDown(0)){ //this is asking when we first detect a touch on the screen we want to find where it began
#		touchStart = Camera.main.ScreenToWorldPoint(Input.MousePosition) convert touch position to world space point.
# 	}
#	if(Input.GetMouseButtonDown(0)){ //this is true for the entire durration of the touch.
#		var direction = Vector2()
#		direction = touchStart - Camera.main.ScreenToWorldPoint(Input.MousePosition)
#		Camera.main.transform.position += direction
# 	} 
	
