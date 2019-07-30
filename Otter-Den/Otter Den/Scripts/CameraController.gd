extends Node

#var touchStart
#var zoomOutMin
#var zoomOutMax

func _ready():
	pass
	
func _input(event):
	pass
	
	
	
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
	
