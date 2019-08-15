extends Node2D

#onready var frogs : Node2D  = $Frogs
onready var path : PoolVector2Array

var nav_2d
var den
var speed = 400.0
#speed will eventually be set by the mob itself. for now I have a defualt value.
#----------------------------------------------------------------------------------------------------------------------------
func _ready() -> void:
#	path = nav_2d._create_path(self.global_position, den.global_position)
	path = nav_2d._create_path(self.position, Vector2(0,550))
	pass
#----------------------------------------------------------------------------------------------------------------------------
func _process(delta: float) -> void:
	if path.size() == 0:
		return
	else:
		var move_distance = speed * delta
		_move_along_path(move_distance)
#----------------------------------------------------------------------------------------------------------------------------
func _move_along_path(distance : float) -> void:
	var start_pos = self.position
	for i in range(path.size()):
		var distance_to_next = start_pos.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			self.position = start_pos.linear_interpolate(path[0], distance / distance_to_next)
#			self.position = start_pos.lerp(path[0], distance / distance_to_next)
			break
		elif distance < 0.0:
			self.position = path[0]
			set_process(false)
			break

# this handles overshooting a point along the path. Basically allows it to backtrack if it goes too fast.
		distance -= distance_to_next
		start_pos = path[0]
		path.remove(0)
#----------------------------------------------------------------------------------------------------------------------------
