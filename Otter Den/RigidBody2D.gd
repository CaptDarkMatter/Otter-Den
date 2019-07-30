extends RigidBody2D
var ship = preload("res://Ship.tscn")
var sx = 603
var sy = 960
var v = 200
var vs = 150

func _ready():
	position = Vector2(800,1200)
	set_physics_process(true)
	pass

func _physics_process(delta):
	if position.x != sx and position.y != sy:
		var dx = sx - position.x
		var dy = sy - position.y
		var d = sqrt(pow(dx,2) + pow(dy,2))
		var ratio = v/d
		set_linear_velocity(Vector2(dx*ratio,dy*ratio+vs))
	else:
		set_linear_velocity(Vector2(0,0))
	pass
	
