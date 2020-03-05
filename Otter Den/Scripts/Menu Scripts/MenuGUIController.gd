extends Control

func _on_Button_pressed():
#	Settings.save_game("res://save(MAP).json",'Game Object')
#	get_node(get_node("/root/Main Menu").currentDot).add_to_group('Level')
#	var save_file = File.new()
#	if not save_file.file_exists("res://save(LEVEL).json"):
#		Settings.save_game("res://save(LEVEL).json",'Level')
#	else:
#		var dir = Directory.new()
#		dir.remove("res://save(LEVEL).json")
#		Settings.save_game("res://save(LEVEL).json",'Level')
#	get_node(get_node("/root/Main Menu").currentDot).remove_from_group('Level')
	get_node(get_node("/root/Main Menu").currentDot).clear = true
	Settings.save_game("res://save(MAP).json",'Game Object')
	get_tree().change_scene("res://Scenes/Game Scene.tscn")


func _on_New_Map_pressed():
	self.get_parent().get_parent().GenerateNewMap(1000)
