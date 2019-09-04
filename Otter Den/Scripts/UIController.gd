extends Control

onready var wallLeft = $Panel/wallLeft
onready var wallRight = $Panel/wallRight 
onready var wallBottom = $Panel/wallTop
onready var wallTop = $Panel/wallBottom
onready var moneybox = $Panel/moneybox
onready var startbox = $Panel/startbox
onready var shipbox = $Panel/shipbox
onready var towerbox = $Panel/towerbox
onready var TowerSubMenu = $Panel/wallRight/TowerSubMenu

onready var menu_open : bool = true
onready var tower_sub_menu_open : bool = false

signal start_pressed
signal tower_spawn_pressed

func _ready():
	TowerSubMenu.rect_position += Vector2(rect_size.x,0)

func show_menu():
	if menu_open:
		wallLeft.rect_position += Vector2(rect_size.x * -1,0)
		wallRight.rect_position += Vector2(rect_size.x,0)
		wallBottom.rect_position += Vector2(0,rect_size.y * -1)
		wallTop.rect_position += Vector2(0,rect_size.y)
		moneybox.rect_position += Vector2(rect_size.x * -1,rect_size.y)
		startbox.rect_position += Vector2(rect_size.x,rect_size.y)
		shipbox.rect_position += Vector2(rect_size.x * -1,rect_size.y * -1)
		towerbox.rect_position += Vector2(rect_size.x * -1,rect_size.y)
		menu_open = false
	else:
		wallLeft.rect_position += Vector2(rect_size.x,0)
		wallRight.rect_position += Vector2(rect_size.x * -1,0)
		wallBottom.rect_position += Vector2(0,rect_size.y)
		wallTop.rect_position += Vector2(0,rect_size.y * -1)
		moneybox.rect_position += Vector2(rect_size.x,rect_size.y * -1)
		startbox.rect_position += Vector2(rect_size.x * -1,rect_size.y * -1)
		shipbox.rect_position += Vector2(rect_size.x,rect_size.y)
		towerbox.rect_position += Vector2(rect_size.x,rect_size.y * -1)
		menu_open = true

func _on_Start_Button_pressed():
	emit_signal("start_pressed")


func _on_TowerMenu_pressed():
	if tower_sub_menu_open:
		TowerSubMenu.rect_position += Vector2(rect_size.x,0)
		tower_sub_menu_open = false
	else:
		TowerSubMenu.rect_position += Vector2(rect_size.x * -1,0)
		tower_sub_menu_open = true


func _on_ItemList_item_selected(index):
#	emit_signal("tower_spawn_pressed")
	pass


func _on_ItemList_item_activated(index):
	emit_signal("tower_spawn_pressed")