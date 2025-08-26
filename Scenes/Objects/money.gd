extends Area2D

var coin_value
var player: CharacterBody2D
func _ready():
	player = get_tree().get_first_node_in_group("Player")
	var choose_type = randi_range(1, 100)
	if choose_type >= 1 and choose_type <= 80:
		coin_value = 0.01
		$AnimatedSprite2D.play("1")
	if choose_type >= 81 and choose_type <= 94:
		$AnimatedSprite2D.play("2")
		coin_value = 0.1
	if choose_type >= 95 and choose_type < 100:
		$AnimatedSprite2D.play("3")
		coin_value = 1
	if choose_type == 100:
		coin_value = 5
		$AnimatedSprite2D.play("4")
	var destination = global_position + Vector2(0, 100)
	var tween = create_tween()
	tween.tween_property(self, "position", destination, 0.4)
	tween.tween_property(self, "position", (destination + Vector2(0, -20)), 0.1)
	tween.tween_property(self, "position", destination, 0.2)

func _on_body_entered(body):
	if body == player:
		body.collect_money(coin_value)
	queue_free()
