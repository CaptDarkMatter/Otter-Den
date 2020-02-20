extends Node2D
var mob = preload("res://Scenes/Mob.tscn")
var ship = preload("res://Scenes/Ship.tscn")
var tower = preload("res://Scenes/Tower.tscn")
onready var newShip = ship.instance()
onready var curHold : bool = false
onready var validPlace : bool = false
var money = 1000
var lives = 20
var price : int
var new_tower_type
onready var wave : int = 0

signal updateUI

func _ready():
	set_process_input(true)
	newShip.position = Vector2(0,0)
	newShip.type = "raft"
	add_child(newShip)
	get_node("Camera2D").position = newShip.position - (get_viewport_rect().size / 2)
	get_node("CanvasLayer/Control").rect_global_position = newShip.position
	emit_signal("updateUI")

func _input(event: InputEvent) -> void:
	if curHold and Input.is_action_just_pressed("mouse_left") and validPlace == true:
		var spawnTower = tower.instance()
		spawnTower.position = get_node("Cursor").position
		spawnTower.type = new_tower_type
		get_node("/root/Game Scene/Ship/TowerBucket").add_child(spawnTower)
		curHold = false
		get_node("Cursor").hide()
		money += (price * -1)
		price = 0
		emit_signal("updateUI")
	elif curHold and event is InputEventScreenTouch and event.pressed == false:
		if  validPlace == true:
			var spawnTower = tower.instance()
			spawnTower.position = get_node("Cursor").position
			spawnTower.type = new_tower_type
			get_node("/root/Game Scene/Ship/TowerBucket").add_child(spawnTower)
			curHold = false
			get_node("Cursor").hide()
			money += (price * -1)
			price = 0
			emit_signal("updateUI")
		else:
			new_tower_type = ""
			price = 0
			curHold = false
			get_node("Cursor").hide()

func _process(delta):
	if curHold:
		get_node("Cursor").position = get_global_mouse_position()

func SpawnMob(var spawnTarget : Vector2, var spawnType : String):
	var spawnMob = mob.instance()
	spawnMob.position = spawnTarget
	spawnMob.type = spawnType
	spawnMob.nav_2d = get_node("Ship").get_child(2)
	spawnMob.den = get_node("Ship/Den")
	get_node("/root/Game Scene/Ship/NavBucket").get_child(0).add_child(spawnMob)

func enemy_spawn(var enemyNumber, var enemyType):
	var spawners = []
	spawners = [Vector2(-540,-960),Vector2(540,-960),Vector2(-540,960),Vector2(540,960)]
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
		var cursor1 : Texture = load("res://Sprites/cannon.png")
		get_node("Cursor").texture = cursor1
		curHold = true
		get_node("Cursor").show()
		price += 500

func _on_Control_TS_harpoon_pressed():
	if money >= 200:
		new_tower_type = "harpoon"
		var cursor2 : Texture = load("res://Sprites/harpoon.png")
		get_node("Cursor").texture = cursor2
		curHold = true
		get_node("Cursor").show()
		price += 200

func mob_killed(var mon):
	money += mon
	emit_signal("updateUI")

func life_lost():
	lives += -1
	emit_signal("updateUI")
	if lives < 1:
		get_tree().change_scene("res://Scenes/Title.tscn")

func _on_Control_BigShip_pressed():
	if money >= 5000:
		money += -5000
		$"Ship".upgrade()
		get_node("Ship").type = "ship1"
		get_node("Ship").TypeList()
		emit_signal("updateUI")
