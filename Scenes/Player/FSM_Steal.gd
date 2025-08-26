extends State

var timer: int
var caught: bool = false

func Enter():
	timer = 10
	animation_tree["parameters/conditions/use"] = true
	var steal_calculator = randi_range(1, 100)

	if entity.NPC.steal_chance_value >= steal_calculator:
		entity.wallet += randf_range(0.01, 1)
		entity.update_ui()
	else:
		var spawners = get_tree().get_nodes_in_group("Spawner")
		var random_index = randi() % spawners.size()
		entity.random_spawner = spawners[random_index]
		entity.police_timer.start()
		caught = true

		if entity.random_spawner.left:
			entity.ui.police_right()
		else:
			entity.ui.police_left()
	entity.NPC.has_been_stolen_from = true
	entity.NPC.can_be_stolen_from = false
	entity.NPC.steal_pop_up_off()
	entity.NPC = null
	entity.steal_progress_UI.visible = false

func Exit():
	animation_tree["parameters/conditions/use"] = false

func Update(delta):
	if timer > 0:
		timer -= delta
	else:
		if caught:
			caught = false
			Transition.emit(self, "idle")
			entity.stealth_mode = false
			entity.ui.deactivate_stealth()
			entity.walk_speed = 200
			entity.can_sprint = true
		else:
			Transition.emit(self, "sneak_mode")
