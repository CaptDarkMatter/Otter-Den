extends RigidBody2D

onready var map : String = str("RigidBody2D:",get_node("/root/Main Menu").Mapid)
var selected : bool = false
var clear : bool = false
var type : String
var waveNum : int = 10
var extents : float = 220

func _ready():
	add_to_group('Game Object')
	TypeList()

func _process(delta):
	if get_node("/root/Main Menu").startup > 0:
		startup()
	
	if clear:
		$ClearedShader.show()
		if type == "end":
			#you win
			pass

	if selected:
		var cam = get_node("/root/Main Menu/Camera2D")
		var diff = cam._touches_info.target - cam._touches_info.cur_pos
		var new_pos = cam.position + (diff * cam.zoom.x)
		if new_pos.x > self.position.x + (extents * 12):
			cam.position.x = self.position.x + (extents * 12)
		if new_pos.x < self.position.x + ((extents * -1) * 12):
			cam.position.x = self.position.x + ((extents * -1) * 12)
		if new_pos.y > self.position.y:
			cam.position.y = self.position.y
		if new_pos.y < self.position.y + ((extents * -1) * 12):
			cam.position.y = self.position.y + ((extents * -1) * 12)

func startup():
	match get_node("/root/Main Menu").startup:
		2:
			var bodies = get_colliding_bodies()
			for body in bodies:
				if body.name == "mapArea":
					remove_from_group('Game Object')
					self.queue_free()
		3:
			$Bumper.disabled = false
		4:
			self.mode = RigidBody2D.MODE_STATIC
			$Bumper.disabled = true
			$dotShape.disabled = true

func TypeList():
	match type:
		"end":
			add_to_group('end')
		"frog":
			pass
		"wolf":
			pass
		"deep":
			pass

#func save():
#	var save_dict = {
#		group="dot",
#		parentPath=self.get_parent().get_path(),
#		pos={
#			x=position.x,
#			y=position.y
#		},
#		mode=self.mode,
#		myName=self.name
#	}
#	return save_dict

func save():
	var save_dict = {
		"group":"dot",
		"parentPath":self.get_parent().get_path(),
		pos={
			"x":position.x,
			"y":position.y
		},
		"mode":self.mode,
		"myName":self.name,
		"type":type,
		"waveNum":waveNum,
		"clear":clear
	}
	return save_dict

func _on_Select_pressed():
	if get_node("/root/Main Menu").travelDist < 1:
		get_node("/root/Main Menu").newDot = self.get_path()
		selected = true
		print("selected: ",selected)
		print(self.get_instance_id())
		get_node("/root/Main Menu/Camera2D").position = self.position + ((get_viewport_rect().size / 2) * -1) 
		if self.clear:
			get_node("/root/Main Menu").travelDist = 0
		else:
			get_node("/root/Main Menu").travelDist += 1
