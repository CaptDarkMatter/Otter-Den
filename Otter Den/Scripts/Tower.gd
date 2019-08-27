extends Node2D

signal shoot

export (PackedScene) var projectile
export (float) var gun_cooldown
export (int) var detect_radius

var can_shoot = true

func control(delta):
	if Input.is_action_just_pressed("mouse_left"):
		shoot()

func shoot():
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		var dir = Vector2(1,0).rotated($Turret.global_rotation)
		emit_signal("shoot", projectile, $Turret/Muzzle.global_position, dir)
		
	pass

func _ready():
	$GunTimer.wait_time = gun_cooldown
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius
	pass

func _on_GunTimer_timeout():
	can_shoot = true
	pass # Replace with function body.
	
func _process(delta):
	control(delta)
	
	
