extends Area2D

export (int) var speed
export (float) var lifetime

var velocity = Vector2()
var type

func start(_position, _direction):
	TypeList()
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
	if type == "cannonball":
		explode()
	var A_parent = area.get_parent()
	if A_parent.has_method('take_damage'):
		A_parent.take_damage()

func TypeList():
	match type:
		"cannonball":
			get_node("BulletSprite").texture = get_node("BulletSprite").cannonball
			get_node("BulletSprite").subPlacer = 0
			speed = 400
			lifetime = 1
		"spike":
			get_node("BulletSprite").texture = get_node("BulletSprite").spike
			get_node("BulletSprite").subPlacer = 1
			speed = 700
			lifetime = 3
	print(type)
	var newShape = RectangleShape2D.new()
	newShape.set_extents(Vector2(get_node("BulletSprite").texture.get_size().x / 2, get_node("BulletSprite").texture.get_size().y / 2))
	get_node("ProjectileShape2D").set_shape(newShape)
