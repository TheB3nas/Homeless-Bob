extends State

var timer: int
#var NPCs
#
#var random_spawner

func Enter():
	timer = 10
	animation_tree["parameters/conditions/use"] = true
	#NPCs = get_tree().get_nodes_in_group("NPC")
	#for NPC in NPCs:
		#if NPC.can_be_stolen_from:
			#NPC.has_been_stolen_from = true
			#NPC.can_be_stolen_from = false
			#var steal_calculator = randi_range(1, 100)
			#if NPC.steal_chance_value >= steal_calculator:
				#entity.wallet += 0.5
				#entity.update_ui()
				#NPC.steal_pop_up_off()
				#break
			#else:
				#var spawners = get_tree().get_nodes_in_group("Spawner")
				#var random_index = randi() % spawners.size()
				#random_spawner = spawners[random_index]
				#$"../../Timers/Police_Spawn_timer".start()
				#if random_spawner.left:
					#$"../../UI".police_right()
				#else:
					#$"../../UI".police_left()
				#NPC.steal_pop_up_off()
				
	
	

func Exit():
	animation_tree["parameters/conditions/use"] = false

func Update(delta):
	if timer > 0:
		timer -= delta
	else:
		Transition.emit(self, "idle")



#func _on_police_spawn_timer_timeout():
	#random_spawner.spawn_police()
