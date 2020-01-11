extends Node2D

export(NodePath) var mobSprite

onready var path : PoolVector2Array

# warning-ignore:unused_class_variable
var gameController
var nav_2d
var den
var type : String
var speed : float
var basic : bool
var reward : int
#----------------------------------------------------------------------------------------------------------------------------
func _ready() -> void:
	TypeList()
#----------------------------------------------------------------------------------------------------------------------------
func _process(delta: float) -> void:
	if path.size() == 0:
		if basic:
			reward = 0
			setType(0)
			get_tree().get_root().get_node("Game Scene").life_lost()
		return
	else:
		var move_distance = speed * delta
		move_along_path(move_distance)
#----------------------------------------------------------------------------------------------------------------------------
func move_along_path(distance : float) -> void:
	get_node(mobSprite).look_at(path[0])
	var start_pos = self.position
# warning-ignore:unused_variable
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
		distance -= distance_to_next
		start_pos = path[0]
		path.remove(0)
#----------------------------------------------------------------------------------------------------------------------------
func setType(var typeToSet : int):
	type = get_node(mobSprite).typeList[typeToSet]
	TypeList()
	get_tree().get_root().get_node("Game Scene").mob_killed(reward)
#----------------------------------------------------------------------------------------------------------------------------
func TypeList():
	match type:
		"frog1":
			get_node(mobSprite).texture = get_node(mobSprite).frog1
			get_node(mobSprite).subPlacer = 1
			speed = 200.0
			basic = true
			path = get_parent()._create_path(self.position, den.position)
			reward = 10
		"frog2":
			get_node(mobSprite).texture = get_node(mobSprite).frog2
			get_node(mobSprite).subPlacer = 2
			speed = 350.0
			basic = true
			path = get_parent()._create_path(self.position, den.position)
			reward = 15
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
	var newShape = RectangleShape2D.new()
	newShape.set_extents(Vector2(get_node(mobSprite).texture.get_size().x / 2, get_node(mobSprite).texture.get_size().y / 2))
	get_node("Mob2D/MobShape2D").set_shape(newShape)
#----------------------------------------------------------------------------------------------------------------------------
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.scancode == KEY_B:
		take_damage()

func take_damage():
	get_node(mobSprite).subPlacer += -1
	setType(get_node(mobSprite).subPlacer)