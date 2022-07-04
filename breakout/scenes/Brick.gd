extends Area2D

export var color = Color.white

func _ready() -> void:
	modulate = color


func _on_Brick_area_entered(area: Area2D) -> void:
	if area is Ball :
		var ball = area as Ball
		var is_below = ball.global_position.y  >= global_position.y + GameManager.BRICK_HEIGHT / 2
		var is_above =  ball.global_position.y  < global_position.y - GameManager.BRICK_HEIGHT / 2
		var is_left = ball.global_position.x  <= global_position.x + GameManager.BRICK_WIDTH / 2
		var is_right = ball.global_position.x  > global_position.x + GameManager.BRICK_WIDTH / 2

		if is_below or is_above :
			ball.velocity.y = - ball.velocity.y
		elif is_left or is_right :
			ball.velocity.x = - ball.velocity.x
		EventBus.emit_signal("brick_hit", color)
		queue_free()
