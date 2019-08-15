extends Node2D
var mob = preload("res://Scenes/Mob.tscn")
var ship = preload("res://Scenes/Ship.tscn")
onready var spawnTarget : Vector2 = Vector2(540,0)

func _ready():
	set_process_input(true)
	var newShip = ship.instance()
	newShip.position = Vector2(540,960)
	add_child(newShip)
	get_node("Camera2D").position = newShip.position

func _input(event: InputEvent) -> void:
	if not event is InputEventKey:
		return
	if event is InputEventKey and event.pressed and event.scancode == KEY_A:
		var spawnMob = mob.instance()
		spawnMob.position = spawnTarget
		spawnMob.nav_2d = get_node("Ship/Navigation2D")
		spawnMob.den = get_node("Ship/Den")
		get_node("Ship/Navigation2D/NavigationPolygonInstance").add_child(spawnMob)