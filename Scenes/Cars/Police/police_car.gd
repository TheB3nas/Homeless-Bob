extends Area2D

var speed = 1000
var left: bool

func _process(delta):
	if left:
		$Sprites.scale.x = -1
		position.x -= speed * delta
	else:
		position.x += speed * delta


func _on_body_entered(body):
	if not body.is_hiding:
		speed = 0
		$Animation/AnimationPlayer.stop()
		body.caught()
