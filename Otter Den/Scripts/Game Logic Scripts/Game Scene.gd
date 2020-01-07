extends Node2D
var mob = preload("res://Scenes/Mob.tscn")
var ship = preload("res://Scenes/Ship.tscn")
var tower = preload("res://Scenes/Tower.tscn")
onready var newShip = ship.instance()
onready var curHold : bool = false
onready var validPlace : bool = true
var money = 5000
var lives = 20
var new_tower_type
onready var wave : int = 0

signal updateUI

func _ready():
	set_process_input(true)
	newShip.position = Vector2(0,0)
	newShip.type = "raft"
	add_child(newShip)
	get_node("Camera2D").position = newShip.position - (get_viewport_rect().size / 2)
#	get_node("CanvasLayer/Control").rect_global_position = get_node("Camera2D").position
	get_node("CanvasLayer/Control").rect_global_position = newShip.position
	print("Press A to spawn some frogs. Press B to hurt the frogs")
	print("Press S to toggle Spawn Mode. Left Clicking in Spawn Mode will spawn a Tower.")
	emit_signal("updateUI")

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
	if curHold and Input.is_action_just_pressed("mouse_left") and validPlace == true:
#		print("mouse!")
		var spawnTower = tower.instance()
		spawnTower.position = get_node("Cursor").position
		spawnTower.type = new_tower_type
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
	spawnMob.nav_2d = get_node("Ship").get_child(2)
	spawnMob.den = get_node("Ship/Den")
#	get_node("Ship/Navigation2D/NavigationPolygonInstance").add_child(spawnMob)
	get_node("Ship").get_child(2).get_child(0).add_child(spawnMob)

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
	wave += 1
	var mobCount = wave + 5 * (wave * 1.02)
	enemy_spawn(mobCount, "frog2")
	print(mobCount)

func _on_Control_TS_cannon_pressed():
	if money >= 500:
		new_tower_type = "cannon"
		curHold = true
		get_node("Cursor").show()
		money += -500
		emit_signal("updateUI")

func _on_Control_TS_harpoon_pressed():
	if money >= 200:
		new_tower_type = "harpoon"
		curHold = true
		get_node("Cursor").show()
		money += -200
		emit_signal("updateUI")

func mob_killed(var mon):
	money += mon
	emit_signal("updateUI")

func life_lost():
	lives += -1
	emit_signal("updateUI")

func _on_Control_BigShip_pressed():
	if money >= 5000:
		money += -5000
		emit_signal("updateUI")
		get_node("Ship").type = "ship1"
		get_node("Ship").TypeList()
