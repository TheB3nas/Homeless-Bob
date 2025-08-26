extends Node2D

var money_scene = preload("res://Scenes/Objects/money.tscn")
var bottle_scene = preload("res://Scenes/Objects/bottle.tscn")

func _ready():
	for trash_can in get_tree().get_nodes_in_group("Trash_can"):
		trash_can.connect("bottle_dropped", on_bottle_dropped)

func connect_NPC(NPC):
	NPC.connect("money_dropped", on_money_dropped)

func on_money_dropped(pos):
	var money = money_scene.instantiate() as Area2D
	money.position = pos
	add_child(money)



func on_bottle_dropped(pos):
	print("drop bottle")
	var bottle = bottle_scene.instantiate() as Area2D
	bottle.position = pos + Vector2(randi_range(-100, 100), -100)
	add_child(bottle)
