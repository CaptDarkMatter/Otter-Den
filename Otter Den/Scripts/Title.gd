extends Node2D

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch or Input.is_action_just_pressed("mouse_left"):
		get_tree().change_scene("res://Scenes/Game Scene.tscn")
