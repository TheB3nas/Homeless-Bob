extends State

func Enter():
	animation_tree["parameters/conditions/sit"] = true
	entity.is_begging = true

func Exit():
	entity.is_begging = false
	animation_tree["parameters/conditions/sit"] = false

func Update(_delta):
	if entity.direction:
		Transition.emit(self, "walk")
