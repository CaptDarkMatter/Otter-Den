extends Camera2D

export(NodePath) var playerPath
var player

func _ready():
	player = get_node(playerPath)
	set_process(true)
	pass

func _process(delta):
	if player.position.y < position.y:
		position = Vector2(0, player.position.y)
	pass                                                 