extends Area2D

export (int) var speed
export (float) var lifetime

var velocity = Vector2()

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	velocity = _direction * speed
	$Lifetime.start()

func _process(delta):
	position += velocity * delta

func explode():
	queue_free()

func _on_Lifetime_timeout():
	explode()


func _on_Projectile_area_entered(area):
	explode()
	var A_parent = area.get_parent()
	if A_parent.has_method('take_damage'):
		A_parent.take_damage()
