extends Sprite

func _ready():
#	var space_state = get_world_2d().direct_space_state
#	var result = space_state.intersect_point(self.position)
	pass

func _process(delta):
	if self.is_visible():
		#if cursor is inside of the deck but is also not inside the navmesh
		if $CursorArea.overlaps_area(get_node("/root/Game Scene/Ship/NavBucket").get_child(0).get_child(2)):
			get_node("/root/Game Scene").validPlace = false
			$OutBounds.show()
		elif $CursorArea.overlaps_area(get_node("/root/Game Scene/Ship/NavBucket").get_child(0).get_child(1)):
			get_node("/root/Game Scene").validPlace = true
			$OutBounds.hide()
		else:
			get_node("/root/Game Scene").validPlace = false
			$OutBounds.show()
	else:
		return
