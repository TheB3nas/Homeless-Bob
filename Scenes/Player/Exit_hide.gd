extends State

var timer: int

func Enter():
	entity.can_hide = false
	timer = 10
	animation_tree["parameters/conditions/hide"] = true
	var pos = entity.position
	var tween = create_tween()
	tween.tween_property(entity, "position", (entity.position+Vector2(0, -30)), 0.2)
	tween.tween_property(entity, "position", pos, 0.3)

func Exit():
	entity.can_hide = true
	animation_tree["parameters/conditions/hide"] = false

func Update(delta):
	if timer > 0:
		timer -= delta
	else:
		Transition.emit(self, "idle")
