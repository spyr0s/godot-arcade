class_name Paddle
extends KinematicBody2D

const HEIGHT := 48

export(String, "left_player_up","right_player_up") var up_movement = "left_player_up"
export(String, "left_player_down","right_player_down") var down_movement = "left_player_down"
export var speed := 300

var  velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed(up_movement) :
		velocity = Vector2.UP
	if Input.is_action_pressed(down_movement) :
		velocity = Vector2.DOWN
	if Input.is_action_just_released(up_movement) :
		velocity = Vector2.ZERO
	if Input.is_action_just_released(down_movement) :
		velocity = Vector2.ZERO
	move_and_slide(velocity * speed)


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.is_in_group("ball") :
		# check the position where the ball hit the paddle
		var col_pos = - (position.y - HEIGHT/2 - area.position.y - area.SIZE /2 )
		SoundManager.play_sound("res://assets/sounds/hit.ogg")
		area.bounce_paddle(col_pos)

