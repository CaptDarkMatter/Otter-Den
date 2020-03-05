extends Node2D

var projectile = preload("res://Scenes/Projectile.tscn")
var targets = []
var target_WF = []
# warning-ignore:unused_class_variable
var myProjectile : String 
var type : String
var cost : int
#signal shoot

export (float) var gun_cooldown
export (int) var detect_radius

var can_shoot = true
#onready var projectileSpawn = self.get_parent().get_node("../")

func _ready():
	add_to_group('Game Object')
	var circle = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape = circle
	TypeList()
	$GunTimer.wait_time = gun_cooldown
#	This is broken for some reason. Whenever i spawn a new tower type, every towers radius changes to that of the new tower.
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius * 10

func shoot():
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		var dir = Vector2(1,0).rotated($Turret.global_rotation)
		var b = projectile.instance()
		b.type = myProjectile
		b.start($Turret/Muzzle.global_position, dir)
		self.get_parent().add_child(b)

func _on_GunTimer_timeout():
	can_shoot = true

func _process(delta):
	if get_node("/root/Game Scene/Cursor").is_visible():
		if $Bounds.overlaps_area(get_node("/root/Game Scene/Cursor/CursorArea")):
			get_node("/root/Game Scene").validPlace = false
			get_node("/root/Game Scene/Cursor/OutBounds").show()

	if targets.size() <= 0: 
		return
	if (!target_WF[0].get_ref()):
		targets.remove(0)
		target_WF.remove(0)
	else:
		self.look_at(targets[0].get_parent().position)
		shoot()

func _on_DetectRadius_area_entered(area):
	var Apos = targets.size()
	var TWFpos = target_WF.size()
	if area.name == "Mob2D":
		targets.insert(Apos, area) 
		target_WF.insert(TWFpos, weakref(targets[targets.size() - 1].get_parent()))

func _on_DetectRadius_area_exited(area):
	targets.remove(0)
	target_WF.remove(0)

func TypeList():
	match type:
		"cannon":
			get_node("Turret").texture = get_node("Turret").cannon
			get_node("Turret").subPlacer = 0
			gun_cooldown = 0.5
			detect_radius = 15
			myProjectile = "cannonball"
			cost = 500
		"harpoon":
			get_node("Turret").texture = get_node("Turret").harpoon
			get_node("Turret").subPlacer = 1
			gun_cooldown = 3
			detect_radius = 30
			myProjectile = "spike"
			cost = 200

#func save():
#	var save_dict = {
#		group="tower",
#		parentPath=self.get_parent().get_path(),
#		pos={
#			x=position.x,
#			y=position.y
#		},
#		type=type,
#		myName=self.name
#	}
#	return save_dict

func save():
	var save_dict = {
		"group":"tower",
		"parentPath":self.get_parent().get_path(),
		pos={
			"x":position.x,
			"y":position.y
		},
		"type":type,
		"myName":self.name
	}
	return save_dict