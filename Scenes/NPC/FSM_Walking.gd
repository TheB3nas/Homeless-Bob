extends State

var speed = randi_range(100, 200) #give variaty to the NPC

func Enter():
	pass

func Exit():
	pass

func Update(delta):
	if entity.left:
		$"../../Sprites".scale.x = -1
		entity.position.x -= speed * delta
	else:
		entity.position.x += speed * delta
