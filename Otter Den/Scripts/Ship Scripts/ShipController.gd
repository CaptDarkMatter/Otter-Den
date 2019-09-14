extends Node2D

var raftPath = preload("res://Scenes/Raft.tscn")
var bigshipPath = preload("res://Scenes/BigShip.tscn")
export(NodePath) var ShipSprite
export(NodePath) var den

onready var denOffset : Vector2
onready var newraftNav = raftPath.instance()
onready var newbigshipNav = bigshipPath.instance()
var type
var newNav

func _ready():
	TypeList()

func TypeList():
	match type:
		"raft":
			if get_child_count() > 2:
				get_child(2).queue_free()
			newNav = newraftNav
			newNav.position = Vector2(0,0)
			add_child(newNav)

			get_node("ShipSprite").texture = get_node("ShipSprite").raft
			get_node("ShipSprite").subPlacer = 0
			get_node(den).position += Vector2(65,-160)
		"ship1":
			if get_child_count() > 2:
				get_child(2).queue_free()
			newNav = newbigshipNav
			newNav.position = Vector2(0,0)
			add_child(newNav)

			get_node("ShipSprite").texture = get_node("ShipSprite").ship1
			get_node("ShipSprite").subPlacer = 1
			get_node(den).position += Vector2(-65,670)