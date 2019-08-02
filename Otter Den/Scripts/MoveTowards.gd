extends Node

var targets
var targetLocation

func _ready():
	targets = 1
	pass

func _move_to(var mover, var location):
	if mover.position != location:
		var do 
	pass
	
func _physics_process(delta):
	match targets:
		1:
			targetLocation = Vector2(400,400)
		2:
			targetLocation = Vector2(300,70)
	
	if self.position == targetLocation:
		targets += 1
	
	_move_to(self, targetLocation)
	pass
