extends Node2D

export(NodePath) var ShipSprite
export(NodePath) var den
onready var denOffset : Vector2
var type

func _ready():
	TypeList()
	pass

func TypeList():
	match type:
		"raft":
			get_node("ShipSprite").texture = get_node("ShipSprite").raft
			get_node("ShipSprite").subPlacer = 0
			get_node(den).position += Vector2(65,-160)
		"ship1":
			get_node("ShipSprite").texture = get_node("ShipSprite").ship1
			get_node("ShipSprite").subPlacer = 1
			get_node(den).position += Vector2(0,525)