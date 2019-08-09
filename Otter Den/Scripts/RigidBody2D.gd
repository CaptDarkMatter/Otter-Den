extends RigidBody2D
var ship = preload("res://Scenes/Ship.tscn").instance()
var targets
var targetLocation
var stupid = preload("res://Scenes/Dumbass.tscn").instance()
var dumbass = preload("res://Scenes/Dumbass.tscn").instance()
#var sx = 603
#var sy = 960
var v = 200
var vs = 150

func _ready():
	set_physics_process(true)
#	position = Vector2(800,1200)
	targets = 1
	pass

func _move_to(var mover, var location, var isMoving):
	if isMoving:
		if mover.position != location:
			var dx = location.x - mover.position.x
			var dy = location.y - mover.position.y
			var d = sqrt(pow(dx,2) + pow(dy,2))
			var ratio = v/d
			mover.set_linear_velocity(Vector2(dx*ratio,dy*ratio))
	else:
		mover.set_linear_velocity(Vector2(0,0)) 
	pass
	
func _physics_process(delta):
	var moving
	match targets:
		1:
			targetLocation = stupid.position
		2:
			targetLocation = dumbass.position
	
	if self.position == targetLocation:
		targets += 1
		moving = false
	else:
		moving = true
	
	_move_to(self, targetLocation, moving)
	print(stupid.position)
	print(dumbass.position)
	pass