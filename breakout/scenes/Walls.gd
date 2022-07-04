extends Control

func bounce_sides(area: Area2D)->void :
	if area is Ball :
		var ball = area as Ball
		ball.velocity.x = - ball.velocity.x


func _on_LeftWall_area_entered(area: Area2D) -> void:
	bounce_sides(area)

func _on_RightWall_area_entered(area: Area2D) -> void:
	bounce_sides(area)


func _on_TopWall_area_entered(area: Area2D) -> void:
	if area is Ball :
		var ball = area as Ball
		ball.velocity.y = - ball.velocity.y



func _on_BottomWall_area_entered(area: Area2D) -> void:
	if area is Ball :
		EventBus.emit_signal("ball_missed")
