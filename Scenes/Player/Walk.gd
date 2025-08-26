extends State

func Enter():
	animation_tree["parameters/conditions/walk"] = true

func Exit():
	animation_tree["parameters/conditions/walk"] = false

func Update(_delta):
	if not entity.direction:
		Transition.emit(self, "idle")
	elif Input.is_action_pressed("Sprint") and entity.can_sprint:
		Transition.emit(self, "Run")
	elif Input.is_action_just_pressed("Sneak"):
		Transition.emit(self, "sneak_mode")
	#elif Input.is_action_just_pressed("Use"):
		#Transition.emit(self, "use")
	elif Input.is_action_just_pressed("Up") and entity.can_hide and not entity.hide_spot.trash_can_is_full:
		Transition.emit(self, "hide")
