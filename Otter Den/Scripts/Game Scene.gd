extends Node2D
var mob = preload("res://Scenes/Mob.tscn")
var ship = preload("res://Scenes/Ship.tscn")
onready var newShip = ship.instance()

func _ready():
	set_process_input(true)
	newShip.position = Vector2(0,0)
	add_child(newShip)
	get_node("Camera2D").position = newShip.position
	print("Press A to spawn some frogs. Press B to hurt the frogs")

func _input(event: InputEvent) -> void:
	if not event is InputEventKey:
		return
	if event is InputEventKey and event.pressed and event.scancode == KEY_A:
		enemy_spawn(20, "frog2")
		pass

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
	for i in range(enemyNumber):
		randomize()
		var spawnerInst = rand_range(0,4)
		SpawnMob(spawners[spawnerInst], enemyType)
		yield(get_tree().create_timer(0.5),"timeout")

func _on_Tower_shoot(projectile, _position, _direction):
    var b = projectile.instance()
    add_child(b)
    b.start(_position, _direction)

