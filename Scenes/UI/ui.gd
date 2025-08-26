extends CanvasLayer

@onready var coin_label = $Money/MarginContainer/VBoxContainer/HBoxContainer/Label
@onready var bottle_label = $Money/MarginContainer/VBoxContainer/HBoxContainer2/Label
@onready var sneak_mode_rec = $ColorRect
var player: CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func update_value(wallet: float, bottles_collected):
	coin_label.text = str(wallet).pad_decimals(2)
	bottle_label.text = str(bottles_collected)
	

func police_left():
	$"Police left".visible = true
	$"Police timer".start()


func police_right():
	$"Police right".visible = true
	$"Police timer".start()

var timer = 3
func _process(_delta):
	if $"Police left".visible:
		$"Police left/MarginContainer/VBoxContainer/Timer".text = str(timer)
	if $"Police right".visible:
		$"Police right/MarginContainer/VBoxContainer/Timer".text = str(timer)
	if Input.is_action_just_pressed("Interact"):
		if $"Shop UI".visible == true:
			$"Shop UI".visible = false
		else:
			$"Shop UI".visible = true

func _on_police_timer_timeout():
	if timer > 0:
		timer -= 1
		$"Police timer".start()
	else:
		timer = 3
		if $"Police left".visible:
			$"Police left".visible = false
		if $"Police right".visible:
			$"Police right".visible = false

func activate_stealth():
	var tween = create_tween()
	tween.tween_property(sneak_mode_rec, "color:a", 0.2, 0.5).set_ease(Tween.EASE_IN)

func deactivate_stealth():
	var tween = create_tween()
	tween.tween_property(sneak_mode_rec, "color:a", 0, 0.5).set_ease(Tween.EASE_IN)

func _on_timer_timeout():
	Globals.time_minutes += 1
	Globals.total_minutes += 1.000
	if Globals.time_minutes == 60:
		Globals.time_minutes = 0
		Globals.time_hours += 1
		if Globals.time_hours == 24:
			Globals.time_hours = 0
	$Clock/TextureRect/PanelContainer/Label.text = str(Globals.time_hours).pad_zeros(2) +":"+ str(Globals.time_minutes).pad_zeros(2)

func caught():
	var tween = create_tween()
	tween.tween_property($caught_screen, "modulate", Color("ffffff"), 1.5)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/test_level.tscn")
