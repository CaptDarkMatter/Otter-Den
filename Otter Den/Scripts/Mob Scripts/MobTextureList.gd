extends Sprite

# warning-ignore:unused_class_variable
onready var typeList : PoolStringArray = ["dead", "frog1", "frog2", "frog3", "dead", "wolf1", "wolf2", "wolf3"]
# warning-ignore:unused_class_variable
var subPlacer : int

# warning-ignore:unused_class_variable
export var frog1 : Texture
# warning-ignore:unused_class_variable
export var frog2 : Texture
# warning-ignore:unused_class_variable
export var frog3 : Texture

# warning-ignore:unused_class_variable
export var wolf1 : Texture
# warning-ignore:unused_class_variable
export var wolf2 : Texture
# warning-ignore:unused_class_variable
export var wolf3 : Texture

#func _ready():
#	texture.get_size()
#	pass