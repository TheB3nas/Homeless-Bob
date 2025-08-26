extends State

func Enter():
	entity.stealth_mode = true
	entity.ui.activate_stealth() 
	entity.can_sprint = false

func Update(_delta):
	entity.steal_progress_bar.value -= 0.5
	
	if entity.steal_progress_bar.value == 0 or not entity.NPC.can_be_stolen_from:
		entity.steal_progress_UI.visible = false
		entity.steal_progress_bar.value = 0
	
	
	if entity.direction:
		animation_tree["parameters/conditions/walk"] = true
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/sprint"] = false
	else:
		animation_tree["parameters/conditions/walk"] = false
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/sprint"] = false
	
	if Input.is_action_just_pressed("Sneak"):
		Exit_stealing()
		if entity.direction:
			Transition.emit(self, "walk")
		else:
			Transition.emit(self, "idle")
	
	if Input.is_action_pressed("Use"):
		var NPCs = get_tree().get_nodes_in_group("NPC")
		for NPC in NPCs:
			if NPC.can_be_stolen_from:
				entity.NPC = NPC
				Transition.emit(self, "stealing")
				break


func Exit_stealing():
	entity.stealth_mode = false
	entity.ui.deactivate_stealth()
	entity.walk_speed = 200
	entity.can_sprint = true
