extends State

func Enter():
	animation_tree["parameters/conditions/idle"] = true

func Exit():
	animation_tree["parameters/conditions/idle"] = false

func Update(_delta):
	if entity.direction and not Input.is_action_pressed("Sprint"):
		Transition.emit(self, "walk")
	elif entity.direction and Input.is_action_pressed("Sprint") and entity.can_sprint:
		Transition.emit(self, "run")
	elif Input.is_action_just_pressed("Beg") and entity.can_beg:
		Transition.emit(self, "beg")
	elif Input.is_action_just_pressed("Sneak"):
		Transition.emit(self, "sneak_mode")
	#elif Input.is_action_just_pressed("Use"):
		#Transition.emit(self, "use")
	elif Input.is_action_just_pressed("Up") and entity.can_hide and not entity.hide_spot.trash_can_is_full:
		Transition.emit(self, "hide")
		print(entity.hide_spot.trash_can_is_full)
