extends Area2D
signal bottle_dropped()


@onready var pop_up = $Sprites/NinePatchRect
var trash_can_is_full = false
var fullness: int = 0
var sprite: int = 1
var player

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		body.hide_spot = self
		pop_up.visible = true
		body.can_hide = true
	if body.is_in_group("NPC"):
		body.trash_can_cal(self)


func _on_body_exited(body):
	if body.is_in_group("Player"):
		body.hide_spot = null
		pop_up.visible = false
		body.can_hide = false



func fill_up():
	if fullness != 20:
		fullness += 1
		play_hide()
	if sprite != 4:
		if fullness == 1 or fullness == 8 or fullness == 20:
			sprite += 1
			$Sprites/AnimatedSprite2D.play(str(sprite))
		if sprite == 4:
			trash_can_is_full = true

func play_hide():
	$Animation/AnimationPlayer.play("Hide")

func search_trash():
	play_hide()
	var min_gain_bottles = null
	var additional_gain_bottles = null
	if fullness == 20:  #chance to get 3 bottles always get 1")
		min_gain_bottles = 1
		additional_gain_bottles = 2
		give_bottles(min_gain_bottles, additional_gain_bottles)

	elif fullness < 20 and fullness >= 8: #chance to get 2 bottles
		min_gain_bottles = 0
		additional_gain_bottles = 2
		give_bottles(min_gain_bottles, additional_gain_bottles)

	elif fullness < 8 and fullness >= 1: # chance to get 1 bottle
		min_gain_bottles = 0
		additional_gain_bottles = 1
		give_bottles(min_gain_bottles, additional_gain_bottles)
	player.update_ui()
		


func give_bottles(min_gain_bottles, additional_gain_bottles):
	if player.bottles_collected < player.hand_size:
		player.bottles_collected += min_gain_bottles
	elif min_gain_bottles != 0:
		drop_bottle()
	for chance in additional_gain_bottles:
		var gain_chance = randi_range(1, 3)
		if gain_chance == 1:
			if player.bottles_collected < player.hand_size:
				player.bottles_collected += 1
			else:
				drop_bottle()
	fullness = 0
	sprite = 1
	$Sprites/AnimatedSprite2D.play("1")

func drop_bottle():
	bottle_dropped.emit(global_position)
