extends RigidBody2D

export(NodePath) var camPath
var world = 'res://World.tscn'

var jump = 1200
var speed = 300
var sprite
var cam

var width
var height

func _ready():
	height = get_viewport_rect().size.y
	width = get_viewport_rect().size.x 
	sprite = get_node("Sprite")
	cam = get_node(camPath)
	set_physics_process(true)
	pass # Replace with function body.

func _physics_process(delta):
	var leftKey = Input.is_action_pressed("ui_left")
	var rightKey = Input.is_action_pressed("ui_right")
	if leftKey:
		set_linear_velocity(Vector2(-speed, get_linear_velocity().y))
		sprite.set_flip_h(false)
	if rightKey:
		set_linear_velocity(Vector2(+speed, get_linear_velocity().y))
		sprite.set_flip_h(true)
	
	if !leftKey and !rightKey:
		set_linear_velocity(Vector2(0, get_linear_velocity().y))
	pass

func collision(body):
	if body.is_in_group('Paddles') and get_linear_velocity().y > 0:
		set_linear_velocity(Vector2(0, -jump))
	pass # Replace with function body.


func exitScreen():
	if position.y > cam.position.y + height / 2:
		print("lose")
		get_tree().change_scene(world)
	
	if position.x > cam.position.x:
		position = Vector2(0, position.y)
	if position.x < cam.position.x:
		position = Vector2(+width, position.y) 
	pass
