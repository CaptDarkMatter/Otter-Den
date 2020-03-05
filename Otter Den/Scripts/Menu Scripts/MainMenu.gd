extends Node2D

var dot = preload("res://Scenes/Dot.tscn")

var nameCounter : int
var startup : int = 1
var dotNum : int
var tries : int
var Mapid
var path

var travelDist : int = 0
var currentDot
var newDot

func _ready():
#	Settings.load_game(Settings.DEFAULT_SAVE_PATH,false)
	Settings.load_game("res://save(MAP).json",true)
	randomize()
	Mapid = str($Map/mapArea.get_instance_id())
	$Camera2D.boundsX = -102150
	$Camera2D.boundsY = -102150
	get_node("Camera2D").position = Vector2(-47000,-60000)
#	update()
#	GenerateNewMap(1000)#replace this with load("res://save(MAP).json",true) once I figure out how to load from the singleton

func _process(delta):
	if currentDot != null:
		var level = get_node(currentDot)
		if not level.clear:
			
			$CanvasLayer/Control/Panel/TextureRect2.show()
	else:
		$CanvasLayer/Control/Panel/TextureRect2.hide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		if currentDot != null and newDot != null:
			if newDot != currentDot:
				get_node(currentDot).selected = false
#				$Map/Boat.position.linear_interpolate(get_node(newDot).position,1)
				$Map/Boat.position = get_node(newDot).position
				currentDot = newDot
		elif newDot != null:
			$Map/Boat.position = get_node(newDot).position
			currentDot = newDot
	elif event is InputEventScreenTouch and event.pressed == false:
		if currentDot != "":
			if newDot != currentDot:
				get_node(currentDot).selected = false
				$Map/Boat.position = get_node(newDot).position
				currentDot = newDot
		elif newDot != null:
			$Map/Boat.position = get_node(newDot).position
			currentDot = newDot

#func _draw():
#	if path:
#		for point in path.get_points():
#			for connection in path.get_point_connections(point):
#				var pp = path.get_point_position(point)
#				var cp = path.get_point_position(connection)
#				draw_line(Vector2(pp.x,pp.y),Vector2(cp.x,cp.y),Color(1,1,0),15,true)

func find_mst(nodes):
	var path = AStar.new()
	path.add_point(path.get_available_point_id(),nodes.pop_front())
	
	while nodes:
		var min_distance = INF
		var min_position = null
		var current_position = null
		for p1 in path.get_points():
			p1 = path.get_point_position(p1)
			for p2 in nodes:
				if p1.distance_to(p2) < min_distance:
					min_distance = p1.distance_to(p2)
					min_position = p2
					current_position = p1
		var n = path.get_available_point_id()
		path.add_point(n, min_position)
		path.connect_points(path.get_closest_point(current_position),n)
		nodes.erase(min_position)
	print("finished generating path")
	return path

func GenerateNewMap(var target : int):
	#introduce a type array variable in betterMap 
	# while int typesComplete < types[].size():
#		do this block of code
	dotNum = 0
	tries = target
	var boundX : int = $Camera2D.boundsX
	var boundY : int = $Camera2D.boundsY
	print("loading...")
	while dotNum < target:
		for i in range(tries):
#			pass the dot type that we are working on from the array into the dot we are spawning.
			var newdot = dot.instance()
			nameCounter += 1
			newdot.name = str("dot",nameCounter)
			newdot.position = Vector2(rand_range(boundX,-1) , rand_range(boundY,-1))
			$Map/bucket.add_child(newdot)
		yield(get_tree().create_timer(1.1), 'timeout')
		startup = 2
		yield(get_tree().create_timer(1.1), 'timeout')
		startup = 1
		dotNum = $Map/bucket.get_child_count()
		tries = target + (dotNum * -1)
#	move the bucket switching code up here before startup = 3. 
#	this is where the top loop breaks and restarts. we do this part again for every type.
#	now we expand and freeze all dots on that maps at once. I might need to make the timer longer.
	print("done! Completed with ",$Map/bucket.get_child_count(),"/",target," dots")
	startup = 3
	yield(get_tree().create_timer(2.0), 'timeout')
	startup = 4
#	transfer bucket code
	for child in $Map/bucket.get_children():
		child.get_parent().remove_child(child)
		$Map/finalBucket.add_child(child)
#	start path code
	yield(get_tree().create_timer(1.1), 'timeout')
	var dotPositions : Array
	for child in $Map/finalBucket.get_children():
		dotPositions.append(Vector3(child.position.x,child.position.y,0))
	path = find_mst(dotPositions)
#	update()
	Settings.save_game("res://save(MAP).json",'Game Object')
	print("game saved!")

func save():
	var save_dict = {
		"path":path
	}
	return save_dict

