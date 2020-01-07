extends Node2D
var mob = preload("res://Scenes/Mob.tscn")
var ship = preload("res://Scenes/Ship.tscn")
var tower = preload("res://Scenes/Tower.tscn")
onready var newShip = ship.instance()
onready var curHold : bool = false

func _ready():
	set_process_input(true)
	newShip.position = Vector2(0,0)
	add_child(newShip)
	get_node("CamParent/Camera2D").position = newShip.position - (get_viewport_rect().size / 2)
	print("Press A to spawn some frogs. Press B to hurt the frogs")
	print("Press S to toggle Spawn Mode. Left Clicking in Spawn Mode will spawn a Tower.")

func _input(event: InputEvent) -> void:
#	if not event is InputEventKey:
#		return
	if event is InputEventKey and event.pressed and event.scancode == KEY_A:
		enemy_spawn(20, "frog2")
#this section of the input is just a stopgap for when the UI is implemented into the code. Will be removed later.
	elif event is InputEventKey and event.pressed and event.scancode == KEY_S:
		if curHold:
			curHold = false
			get_node("Cursor").hide()
		else: 
			curHold = true 
			get_node("Cursor").show()
	if curHold and Input.is_action_just_pressed("mouse_left"):
#		print("mouse!")
		var spawnTower = tower.instance()
		spawnTower.position = get_node("Cursor").position
		newShip.add_child(spawnTower)
		curHold = false
		get_node("Cursor").hide()

# warning-ignore:unused_argument
func _process(delta):
	if curHold:
		get_node("Cursor").position = get_global_mouse_position()

func SpawnMob(var spawnTarget : Vector2, var spawnType : String):
	var spawnMob = mob.instance()
	spawnMob.position = spawnTarget
	spawnMob.type = spawnType
	spawnMob.nav_2d = get_node("Ship/Navigation2D")
	spawnMob.den = get_node("Ship/Den")
	get_node("Ship/Navigation2D/NavigationPolygonInstance").add_child(spawnMob)

func enemy_spawn(var enemyNumber, var enemyType):
	var spawners = []
	spawners = [Vector2(-540,-960),Vector2(540,-960),Vector2(-540,960),Vector2(540,960)]
# warning-ignore:unused_variable
	for i in range(enemyNumber):
		randomize()
		var spawnerInst = rand_range(0,4)
		SpawnMob(spawners[spawnerInst], enemyType)
		yield(get_tree().create_timer(0.5),"timeout")

func buttTest():
	enemy_spawn(20, "frog2")

func _on_Control_tower_spawn_pressed():
	curHold = true
	get_node("Cursor").show()
