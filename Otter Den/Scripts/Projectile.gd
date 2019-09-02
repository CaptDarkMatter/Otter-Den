extends Area2D

export (int) var speed
export (int) var damage
export (float) var lifetime

var velocity = Vector2()

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	velocity = _direction * speed
	pass

func _process(delta):
	position += velocity * delta

func _ready():
	pass

func explode():
	queue_free()

func _on_Projectile_body_entered(body):
	explode()
	if body.has_method('take_damage'):
		body.take_damage(damage)
	pass # Replace with function body.

func _on_Lifetime_timeout():
	explode()
	pass # Replace with function body.
