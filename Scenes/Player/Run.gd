extends State

func Enter():
	animation_tree["parameters/conditions/sprint"] = true

func Exit():
	animation_tree["parameters/conditions/sprint"] = false

func Update(_delta):
	if not entity.direction or not entity.can_sprint:
		Transition.emit(self, "idle")
	if not Input.is_action_pressed("Sprint"):
		Transition.emit(self, "walk")
	elif Input.is_action_just_pressed("Sneak"):
		Transition.emit(self, "sneak_mode")
	#elif Input.is_action_just_pressed("Use"):
		#Transition.emit(self, "use")
	elif Input.is_action_just_pressed("Up") and entity.can_hide and not entity.hide_spot.trash_can_is_full:
		Transition.emit(self, "hide")
