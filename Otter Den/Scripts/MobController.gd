extends Node2D

export(NodePath) var mobSprite

onready var path : PoolVector2Array

var nav_2d
var den
var type : String
var speed : float
#speed will eventually be set by the mob itself. for now I have a defualt value.
#----------------------------------------------------------------------------------------------------------------------------
func _ready() -> void:
	TypeList()
	path = nav_2d._create_path(self.position, den.position)
#----------------------------------------------------------------------------------------------------------------------------
func _process(delta: float) -> void:
	if path.size() == 0:
		return
	else:
		var move_distance = speed * delta
		move_along_path(move_distance)
#----------------------------------------------------------------------------------------------------------------------------
func move_along_path(distance : float) -> void:
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
func setType(var typeToSet : int):
	type = get_node(mobSprite).typeList[typeToSet]
	TypeList()
#----------------------------------------------------------------------------------------------------------------------------
func TypeList():
	match type:
		"frog1":
			get_node(mobSprite).texture = get_node(mobSprite).frog1
			get_node(mobSprite).subPlacer = 1
			speed = 200.0
		"frog2":
			get_node(mobSprite).texture = get_node(mobSprite).frog2
			get_node(mobSprite).subPlacer = 2
			speed = 350.0
		"frog3":
			get_node(mobSprite).texture = get_node(mobSprite).frog3
			get_node(mobSprite).subPlacer = 3

		"wolf1":
			get_node(mobSprite).texture = get_node(mobSprite).wolf1
			get_node(mobSprite).subPlacer = 5
		"wolf2":
			get_node(mobSprite).texture = get_node(mobSprite).wolf2
			get_node(mobSprite).subPlacer = 6
		"wolf3":
			get_node(mobSprite).texture = get_node(mobSprite).wolf3
			get_node(mobSprite).subPlacer = 7
		_:
#			if its anything other than the types above then its dead. So this is where we kill it.
			queue_free()
#----------------------------------------------------------------------------------------------------------------------------
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.scancode == KEY_B:
		get_node(mobSprite).subPlacer += -1
		setType(get_node(mobSprite).subPlacer)