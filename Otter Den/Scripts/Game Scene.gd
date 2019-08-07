extends Node2D
var Frog = preload("res://Scenes/Frog.tscn")


func _ready():
	var NewFrog = Frog.instance()
	NewFrog.position = Vector2(0,0)
	add_child(NewFrog)
	pass
	

