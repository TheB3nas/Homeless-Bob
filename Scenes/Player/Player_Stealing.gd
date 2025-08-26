extends State

@onready var steal_progress_hide_timer = $"../../Timers/Steal_progress_hide_timer"


func Enter():
	entity.is_stealing = true
	steal_progress_hide_timer.stop()
	entity.steal_progress_UI.visible = true
	entity.NPC.is_being_stolen_from = true

func Exit():
	entity.is_stealing = false
	entity.NPC.is_being_stolen_from = false
	steal_progress_hide_timer.start()
	animation_tree["parameters/conditions/walk"] = false
	animation_tree["parameters/conditions/idle"] = false

func Update(_delta):
	if entity.direction:
		animation_tree["parameters/conditions/walk"] = true
		animation_tree["parameters/conditions/idle"] = false
	else:
		animation_tree["parameters/conditions/walk"] = false
		animation_tree["parameters/conditions/idle"] = true
	
	if Input.is_action_just_pressed("Sneak") or not entity.is_stealing:
		entity.steal_progress_UI.visible = false
		entity.steal_progress_bar.value = 0
		Exit_stealing()
		if entity.direction:
			Transition.emit(self, "walk")
		else:
			Transition.emit(self, "idle")
	
	if Input.is_action_pressed("Use") and entity.NPC.can_be_stolen_from:
		if entity.steal_progress_bar.value >= 100:
			Transition.emit(self, "steal")
			entity.steal_progress_bar.value = 0
		else:
			entity.steal_progress_bar.value += 0.5
	else:
		Transition.emit(self, "sneak_mode")


func Exit_stealing():
	entity.stealth_mode = false
	entity.ui.deactivate_stealth()
	entity.walk_speed = 200
	entity.can_sprint = true


func _on_steal_progress_hide_timer_timeout():
	entity.steal_progress_UI.visible = false
