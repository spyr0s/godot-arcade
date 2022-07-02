extends Area2D

export var speed := 300
export var min_speed := 300
export var max_speed: = 600
export var speed_increase := 50

var velocity: = Vector2.ZERO

func _ready() -> void:
	velocity = Vector2(-0.5 if randf() < 0.5 else 0.5,  0.5)

func _physics_process(delta: float) -> void:
	position += velocity.normalized() * speed * delta

func bounce_paddle(pos: float)->void:
	# check offset for the ball velocity.y
	# the higher it hit the paddle more upward is the angle of the reflection
	# the lower it hit , more downward the angle
	var offset =  ((pos * 3)/48) - 1.5
	velocity.x = - velocity.x
	velocity.y = clamp(velocity.y  + offset, -1, 1)
	# for each contact raise the ball speed
	speed = clamp(speed + speed_increase, min_speed, max_speed)

func spawn()->void:
	speed = min_speed
	velocity = Vector2.ZERO
	position = Vector2(424, 1)
	velocity = Vector2(-0.5 if randf() < 0.5 else 0.5, 0.5)
