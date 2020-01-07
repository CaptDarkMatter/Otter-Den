extends Node2D

var projectile = preload("res://Scenes/Projectile.tscn")
var targets = []
var target_WF = []
# warning-ignore:unused_class_variable
var myProjectile : String 

#signal shoot

export (float) var gun_cooldown
export (int) var detect_radius

var can_shoot = true
#onready var projectileSpawn = self.get_parent().get_node("../")

func _ready():
	$GunTimer.wait_time = gun_cooldown
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius * 10

func shoot():
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		var dir = Vector2(1,0).rotated($Turret.global_rotation)
		var b = projectile.instance()
		self.get_parent().add_child(b)
		b.start($Turret/Muzzle.global_position, dir)

func _on_GunTimer_timeout():
	can_shoot = true

# warning-ignore:unused_argument
func _process(delta):
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

# warning-ignore:unused_argument
func _on_DetectRadius_area_exited(area):
	targets.remove(0)
	target_WF.remove(0)
