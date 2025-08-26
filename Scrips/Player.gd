extends CharacterBody2D

#-----------------------Variables----------------------------------------------------------------------------------------
#--------------------------INT------------------------------------------------------------------------------------------------------------------

var walk_speed: int = 200
var sprint_speed: int = 600

#-----------------------BOOLIANS-------------------------------------------------------------------------------------------

var can_move: bool = true #Dictates if a player can move
var is_begging: bool = false #Dictates if a player is begging and can earn money from begging / is turned on in the beg FSM node 
var can_beg: bool = true #Dictates if a player can beg, is used for while hiding, the player cannot hide and beg
var can_hide: bool = false #Dictates if a player can hide in a trash can and bushes, is truned on from hiding spots script
var is_hiding: bool = false #Dictats if a player is hiding, should create a new FSM node that turns this on, right now turned on in player script
var stealth_mode: bool = false
var can_sprint: bool = true
var is_stealing: bool = false
var can_deposit: bool = false

#-----------------------Stats-----------------------------------------------------------------------------------------------

var wallet = 0.00 #players money
var bottles_collected = 0
var chance_to_steal = 5 #players chance to steal form an NPC, used in "Use" FSM node, affected by NPC eyelines (raycasts)
var hand_size = 5 

#-----------------------Other----------------------------------------------------------------------------------------

var direction #Show which direction the player is going
var hide_spot: Area2D # Trash can node
var NPC
var random_spawner

#-----------------------On Ready variables---------------------------------------------------------------------------------

@onready var steal_progress_UI = $NinePatchRect
@onready var steal_progress_bar = $NinePatchRect/MarginContainer/TextureProgressBar
@onready var ui = $UI
@onready var police_timer = $Timers/Police_Spawn_timer

#-----------------------READY SCRIP--------------------------------------------------------------------------------------
#------------Everything that happens before the player is loaded------------------------------------------------------

func _ready():
	ui.update_value(wallet, bottles_collected)

#-----------------------Process scrips------------------------------------------------------------------------------
#------------Everything that happens every frame-----------------------------------------------


func _process(_delta):
	movement_and_sprinting() #calculate movement and sprinting, check if player can move
	flip_sprite() #flip the sprite to look like the player is moving left and right
	if can_deposit and Input.is_action_just_pressed("Up"):
		wallet += bottles_collected * 0.1
		bottles_collected = 0
		ui.update_value(wallet, bottles_collected)
	if hide_spot and Input.is_action_just_pressed("Use"):
		hide_spot.search_trash()
		


func movement_and_sprinting():
	direction = Input.get_axis("Left", "Right") #Check if player is pressing left (A) or right (D) and return the direction (-1 or 1)
	if Input.is_action_pressed("Sprint") and can_sprint: #Check if player is tryign to sprint
		velocity.x = sprint_speed * direction #if sprinting use sprint_speed var
	else: 
		velocity.x = walk_speed * direction #if not sprinting use walking_speed var
	if can_move: #check if a player can move if can let it move
		move_and_slide()

func flip_sprite():
	if direction == 1:
		$Sprites.scale.x = 1
	elif direction == -1:
		$Sprites.scale.x = -1

#-----------------------Sometimes script------------------------------------------------------------------------------
#------------Script that is triggered sometimes to help with performance------------------------------------------------------

func collect_money(coin_value): #Trigges when entering a coin
	wallet += coin_value
	update_ui()

func update_ui(): #update UI
	ui.update_value(wallet, bottles_collected)



func caught():
	can_move = false
	ui.caught()


func _on_police_spawn_timer_timeout():
	random_spawner.spawn_police()
