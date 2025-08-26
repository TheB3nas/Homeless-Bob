extends Area2D


func _ready():
	var destination = global_position + Vector2(0, 100)
	var tween = create_tween()
	tween.tween_property(self, "position", destination, 0.4)
	tween.tween_property(self, "position", (destination + Vector2(0, -20)), 0.1)
	tween.tween_property(self, "position", destination, 0.2)




func _on_body_entered(body):
	if body.bottles_collected < body.hand_size:
		body.bottles_collected += 1 
		body.update_ui()
		queue_free()
	else:
		pass
