extends State

var timer: int
var entity_position

func Enter():
	entity.hide_spot.play_hide()
	entity_position = entity.global_position
	var hide_spot_pos = Vector2(entity.hide_spot.global_position.x, entity.global_position.y)
	timer = 10
	animation_tree["parameters/conditions/hide"] = true
	var tween = create_tween()
	tween.tween_property(entity, "position", (hide_spot_pos+Vector2(0, -30)), 0.2)
	tween.tween_property(entity, "position", hide_spot_pos, 0.3)

func Exit():
	entity.can_beg = true
	entity.visible = true
	entity.is_hiding = false
	entity.hide_spot.play_hide()
	animation_tree["parameters/conditions/hide"] = false
	#var tween = create_tween()
	#tween.tween_property(entity, "position", entity_position, 0.5)

func Update(delta):
	if timer > 0:
		timer -= delta
	else:
		entity.can_beg = false
		entity.visible = false
		entity.is_hiding = true
		if Input.is_action_just_pressed("Up"):
			Transition.emit(self, "exit_hide")
