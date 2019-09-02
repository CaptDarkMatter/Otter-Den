extends Node2D

signal shoot

export (PackedScene) var projectile
export (float) var gun_cooldown
export (int) var detect_radius

var can_shoot = true
var target = null
var turret_speed

func control(delta):
	if Input.is_action_just_pressed("mouse_left"):
		shoot()

func shoot():
	print("start")
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		var dir = Vector2(1,0).rotated($Turret.global_rotation)
		emit_signal("shoot", projectile, $Turret/Muzzle.global_position, dir)
	pass

func _ready():
#	var circle = CircleShape2D.new()
#	$GunTimer.wait_time = gun_cooldown
#	$DetectRadius/CollisionShape2D.shape = circle
#	$DetectRadius/CollisionShape2D.shape.radius = detect_radius
	pass

func _on_GunTimer_timeout():
	can_shoot = true
	pass # Replace with function body.
	
func _process(delta):
	if target:
		var target_dir = (target.global_position - global_position).normalized
		var current_dir = Vector2(1,0).rotated($Turret.global_rotation)
		$Turret.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed)
		if target_dir.dot(current_dir) > 0.9:
			shoot()
	control(delta)

func _on_DetectRadius_body_shape_entered(body_id, body, body_shape, area_shape):
	print("start")
	target = body
	pass # Replace with function body.

func _on_DetectRadius_body_shape_exited(body_id, body, body_shape, area_shape):
	if body == target:
		target = null
	pass # Replace with function body.
