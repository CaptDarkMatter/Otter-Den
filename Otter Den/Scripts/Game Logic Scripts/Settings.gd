extends Node

var dot = preload("res://Scenes/Dot.tscn")
var tower = preload("res://Scenes/Tower.tscn")

const DEFAULT_SAVE_PATH = "res://save.json" #this must be changed to user:// before being built to a device.
var _settings = {}

func _ready():
	load_game(DEFAULT_SAVE_PATH , false)

func save_game(var save_path, var group):
	var SAVE_PATH = save_path
	#get all save data from persistent nodes
	var save_dictionary = {}
	var nodes_to_save = get_tree().get_nodes_in_group(group)
	for node in nodes_to_save:
		save_dictionary[node.get_path()] = node.save()

	#Create a file
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)

	#serialize the data dictionary to JSON
	save_file.store_line(to_json(save_dictionary))
	save_file.close()
	print("saving complete")

func load_game(var save_path , var local : bool):
	var SAVE_PATH = save_path
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		return

	save_file.open(SAVE_PATH, File.READ)
	var data = {}
	data = parse_json(save_file.get_as_text())

	if not local:
		for node_path in data.keys():
			var node = get_node(node_path)
			if node != null:
				for attribute in data[node_path]:
					if attribute == "pos":
						node.position = Vector2(data[node_path]['pos']['x'],data[node_path]['pos']['y'])
					else:
						node.set(attribute, data[node_path][attribute])
	else:
		#create the nodes
		for node_path in data.keys():
			for attribute in data[node_path]:
				if attribute == "group":
					match data[node_path]['group']:
						"dot":
							var newnode = dot.instance()
							get_node(data[node_path]['parentPath']).add_child(newnode)
							newnode.name = data[node_path]['myName']
						"tower":
							var newnode = tower.instance()
							newnode.name = str(data[node_path]['myName'])
							newnode.type = data[node_path]['type']
							get_node(data[node_path]['parentPath']).add_child(newnode)
						_:
							print("error loading group from save. Group named ",data[node_path]['group']," not found.")
							return
		#Load data into the nodes
		for node_path in data.keys():
			var node = get_node(node_path)
			if node != null:
				for attribute in data[node_path]:
					if attribute == "pos":
						node.position = Vector2(data[node_path]['pos']['x'],data[node_path]['pos']['y'])
					else:
						node.set(attribute, data[node_path][attribute])
	print("loading complete")
