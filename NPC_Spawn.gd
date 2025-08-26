extends Node2D

var npc_scene = preload("res://Scenes/NPC/npc.tscn")
var police_car_scene = preload("res://Scenes/Cars/Police/police_car.tscn")
@export var left: bool
var timer: int
var on_run_position

@export var min_timer = 100
@export var max_timer = 400

func _ready() -> void:
	var initial_spawning_int: int = randi_range(2, 6)
	for i in initial_spawning_int:
		if left:
			on_run_position = Vector2(randi_range(-100, -5000), $Marker2D.position.y)
		else:
			on_run_position = Vector2(randi_range(100,5000), $Marker2D.position.y)
		print(on_run_position)
		spawn_NPC()
	on_run_position = Vector2(0, 0)

func randomize_timer():
	timer = randi_range(min_timer, max_timer)

func _process(delta):
	if timer > 0:
		timer -= delta
	else:
		randomize_timer()
		spawn_NPC()

func spawn_NPC():
	var npc = npc_scene.instantiate() as CharacterBody2D
	npc.position = $Marker2D.position + on_run_position
	if left:
		npc.left = true
	var ordering = randi_range(1, 2)
	if ordering == 1:
		npc.z_index = -50
		npc.position += Vector2(0, -30)
	else: 
		npc.z_index = 50
		npc.position += Vector2(0, 10)
	add_child(npc)
	
func spawn_police():
	var police_car = police_car_scene.instantiate() as Area2D
	police_car.position = $Marker2D.position + Vector2(0, 80)
	if left:
		police_car.left = true
	add_child(police_car)
