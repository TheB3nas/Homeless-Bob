extends CharacterBody2D
signal money_dropped()

#-----------------------Variables----------------------------------------------------------------------------------------
#--------------------------INT--------------------------------------------------------------------------------------------

var give_range = randi_range(100, 300) #Range from which they will give money to the player
var will_notice_timer: int = randi_range(50, 150)


#--------------------------BOOLIANS--------------------------------------------------------------------------------------------

var left: bool #Check to see if the sprite should be flipped
var will_give: bool #Boolian to check if the NPC will give money
var has_not_given = true #If true will not give more money, prevents from spamming money
var can_be_stolen_from = false #Check if the player is in range of stealing from this NPC
var has_been_stolen_from = false #Check if the NPC has been stolen from, prevents stealing from the same NPC more tahn once
var is_being_stolen_from = false


var update_chance_to_steal = false #if true will update the chance to steal / was implemented to help with changing chances based on eyelines
var sees_player = false #a check to see if the NPC has eyes on a player

#-----------------------Other-----------------------------------------------------------------------------

var player: CharacterBody2D #Calculate distance between player and NPC
var perception_bonus = randi_range(-20, 50)
var steal_chance_value

var eye_line_rot = randi_range(0, 45)
@onready var eye_line = $Sprites/Eyeline
@onready var ray_cast = $Sprites/Eyeline/RayCast2D
@onready var steal_pop_up = $"Steal pop-up"
@onready var notice = $Sprites/Notice

func _ready():
	randomize_apearance()
	Debug.connect_NPC(self)
	player = get_tree().get_first_node_in_group("Player")
	var will_give_chance = randi_range(1, 2)
	if will_give_chance == 1:
		will_give = true
	eye_line.rotation_degrees = eye_line_rot

func _process(delta):
	steal_chance_value = player.chance_to_steal + perception_bonus
	var distance = (player.global_position - global_position)
	if player.is_begging and distance.length() < give_range and will_give and has_not_given:
		has_not_given = false
		money_dropped.emit(global_position)
	
	
	if ray_cast.is_colliding():
		if ray_cast.get_collider() == player:
			if not sees_player:
				sees_player = true
				player.chance_to_steal -= 5
				
	else:
		if sees_player:
			sees_player = false
			player.chance_to_steal += 5
		
	if update_chance_to_steal:
		$"Steal pop-up/MarginContainer/VBoxContainer/ProgressBar".value = steal_chance_value
		
	if is_being_stolen_from:
		if will_notice_timer > 0:
			will_notice_timer -= delta
		else:
			will_notice_timer = randi_range(50, 150)
			notice.visible = true
			$"Timer/Notice timer".start()

func trash_can_cal(trash_can):
	var will_trash = randi_range(1, 2)
	if will_trash == 1:
		trash_can.fill_up()
	


func _on_self_destruct_timeout():
	queue_free()

func steal_pop_up_off():
	$"Steal pop-up".visible = false

func _on_area_2d_body_entered(body):
	if body == player:
		$Timer/Update.start()
		

func _on_area_2d_body_exited(body):
	if body == player:
		$Timer/Update.stop()
		$"Steal pop-up".visible = false
		update_chance_to_steal = false
		can_be_stolen_from = false

@onready var hair_front = $Sprites/Body/Head/Hair/Hair
@onready var hair_back = $Sprites/Body/Head/Hair/Hair_back
@onready var mouth = $Sprites/Body/Head/Face/Mouth
@onready var pupils = $Sprites/Body/Head/Face/Eyes/Pupil
@onready var eyebrows = $Sprites/Body/Head/Face/Eyes/Eyebrow
@onready var shirt_body = $Sprites/Body/Shirt
@onready var shirt_left_shoulder = $"Sprites/Body/left Shoulder/Shoulder T-shirt"
@onready var shirt_left_arm = $"Sprites/Body/left Shoulder/left Arm/Arm T-Shirt"
@onready var shirt_right_shoulder = $"Sprites/Body/right Shoulder/Shoulder T-shirt"
@onready var shirt_right_arm = $"Sprites/Body/right Shoulder/Right arm/Arm T-Shirt"
@onready var jacket = $Sprites/Body/Jacket
@onready var jacket_left_shoulder = $"Sprites/Body/left Shoulder/Shoulder Front"
@onready var jacket_left_arm = $"Sprites/Body/left Shoulder/left Arm/Arm Front"
@onready var jacket_right_shoulder = $"Sprites/Body/right Shoulder/Shoulder Front"
@onready var jacket_right_arm = $"Sprites/Body/right Shoulder/Right arm/Arm Front"
@onready var first_1 = $"Sprites/Body/left Shoulder/left Arm/Fist 1"
@onready var first_2 = $"Sprites/Body/right Shoulder/Right arm/Fist 2"
@onready var leg_base = $"Sprites/Body/Legs/Leg base/Base"
@onready var belt = $Sprites/Body/Belt
@onready var leg_left_1 = $"Sprites/Body/Legs/l_Leg/Leg 1"
@onready var leg_left_2 = $"Sprites/Body/Legs/l_Leg/L_leg 2/Leg 2"
@onready var leg_right_1 = $"Sprites/Body/Legs/R_Leg/Leg 1"
@onready var leg_right_2 = $"Sprites/Body/Legs/R_Leg/R_leg 2/Leg 2"
@onready var socks_left = $"Sprites/Body/Legs/l_Leg/L_leg 2/Feet/Socks"
@onready var socks_right = $"Sprites/Body/Legs/R_Leg/R_leg 2/Feet/Socks"
@onready var shoe_left = $"Sprites/Body/Legs/l_Leg/L_leg 2/Feet/Shoe"
@onready var shoe_right = $"Sprites/Body/Legs/R_Leg/R_leg 2/Feet/Shoe"
@onready var neck = $Sprites/Body/Neck
@onready var face =$Sprites/Body/Head/Face/Face

func randomize_apearance():
	randomize_color()
	var random_hair = randi_range(1, 4)
	hair_front.play(str(random_hair))
	hair_back.play(str(random_hair))

	var random_mouth = randi_range(1, 7)
	mouth.play(str(random_mouth))

	var random_eyebrow = randi_range(1, 2)
	eyebrows.play(str(random_eyebrow))

	var random_jacket = randi_range(0, 2)
	jacket.play(str(random_jacket)) #I have 3 types Only 3rd needs arms
	if random_jacket == 2:
		var random_jacket_arm = randi_range(1, 2)
		#jacket_left_shoulder.play(str(random_jacket)) #I have 1 types
		jacket_left_arm.play(str(random_jacket_arm)) #I have 2 types
		#jacket_right_shoulder.play(str(random_jacket)) #I have 1 types
		jacket_right_arm.play(str(random_jacket_arm)) #I have 2 types
	else:
		jacket_left_shoulder.visible = false
		jacket_left_arm.visible = false
		jacket_right_shoulder.visible = false
		jacket_right_arm.visible = false

	var random_shirt = randi_range(1, 2)
	shirt_body.play(str(random_shirt))
	if random_jacket == 2:
		shirt_left_shoulder.visible = false
		shirt_left_arm.visible = false
		shirt_right_shoulder.visible = false
		shirt_right_arm.visible = false
	
	var random_belt = randi_range(1, 3)
	belt.play(str(random_belt))
	
	var random_shoe = randi_range(1, 2)
	shoe_left.play(str(random_shoe))
	shoe_right.play(str(random_shoe))

func randomize_color():
	var skin_colors = ["be8a64", "a0704d", "a0704d", "d3ad7c", "ab8655", "674e2c"]
	var random_skin_color_index = randi() % skin_colors.size()
	var random_skin = skin_colors[random_skin_color_index]
	face.modulate = random_skin
	neck.modulate = random_skin
	first_1.modulate = random_skin
	first_2.modulate = random_skin
	
	var hair_colors = ["8c5a45", "502815", "c56109", "805828", "df9a1d", "fed59d", "ceb8ac"]
	var random_hair_color_index = randi() % hair_colors.size()
	var random_hair = hair_colors[random_hair_color_index]
	hair_front.modulate = random_hair
	hair_back.modulate = random_hair
	mouth.modulate = random_hair
	eyebrows.modulate = random_hair
	
	var pupil_colors = ["006d6d", "009c9c", "00764c", "00764c", "00764c"]
	var random_pupil_color_index = randi() % pupil_colors.size()
	var random_pupil = pupil_colors[random_pupil_color_index]
	pupils.modulate = random_pupil
	
	var shirt_colors = ["7f71c0", "b26182", "aa6f4c", "808541", "548f61", "3f8f85", "8cb1b5", "ce9a94", "bea950", "303532", "252a27", "e0e1e0"]
	var random_shirt_color_index = randi() % shirt_colors.size()
	var random_shirt = shirt_colors[random_shirt_color_index]
	shirt_body.modulate = random_shirt
	shirt_left_shoulder.modulate = random_shirt
	shirt_left_arm.modulate = random_shirt
	shirt_right_shoulder.modulate = random_shirt
	shirt_right_arm.modulate = random_shirt

	var jacket_colors = ["7f71c0", "b26182", "aa6f4c", "808541", "548f61", "3f8f85", "8cb1b5", "ce9a94", "bea950", "303532", "252a27", "e0e1e0"]
	var random_jacket_color_index = randi() % jacket_colors.size()
	var random_jacket = jacket_colors[random_jacket_color_index]
	jacket.modulate = random_jacket
	jacket_left_shoulder.modulate = random_jacket
	jacket_left_arm.modulate = random_jacket
	jacket_right_shoulder.modulate = random_jacket
	jacket_right_arm.modulate = random_jacket

	var pants_colors = ["595959", "353535", "2c344b", "4f5b7e", "775d3c", "93754e", "4a3822", "37544e", "427a5e", "a05155"]
	var random_pants_color_index = randi() % pants_colors.size()
	var random_pants = pants_colors[random_pants_color_index]
	leg_base.modulate = random_pants
	leg_left_1.modulate = random_pants
	leg_left_2.modulate = random_pants
	leg_right_1.modulate = random_pants
	leg_right_2.modulate = random_pants
	
	var socks_colors = ["7f71c0", "b26182", "aa6f4c", "808541", "548f61", "3f8f85", "8cb1b5", "ce9a94", "bea950", "303532", "252a27", "e0e1e0", "be8a64", "a0704d", "a0704d", "d3ad7c", "ab8655", "674e2c"]
	var random_socks_color_index = randi() % socks_colors.size()
	var random_socks = socks_colors[random_socks_color_index]
	socks_right.modulate = random_socks
	socks_left.modulate = random_socks

	var shoes_colors = ["7f71c0", "b26182", "aa6f4c", "808541", "548f61", "3f8f85", "8cb1b5", "ce9a94", "bea950", "303532", "252a27", "e0e1e0", "be8a64", "a0704d", "a0704d", "d3ad7c", "ab8655", "674e2c"]
	var random_shoes_color_index = randi() % shoes_colors.size()
	var random_shoes = shoes_colors[random_shoes_color_index]
	shoe_left.modulate = random_shoes
	shoe_right.modulate = random_shoes


func _on_update_timeout():
	if player.stealth_mode:
		player.walk_speed = $FSM/Walking.speed
		update_chance_to_steal = true
		if not has_been_stolen_from:
			can_be_stolen_from = true
			$"Steal pop-up".visible = true
		else:
			$"Steal pop-up".visible = false



func _on_notice_timer_timeout():
	if is_being_stolen_from:
		player.is_stealing = false
		var spawners = get_tree().get_nodes_in_group("Spawner")
		var random_index = randi() % spawners.size()
		player.random_spawner = spawners[random_index]
		notice.visible = false
		player.police_timer.start()
		if player.random_spawner.left:
			player.ui.police_right()
		else:
			player.ui.police_left()
	else:
		notice.visible = false
