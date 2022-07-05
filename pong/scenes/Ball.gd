class_name Ball
extends Area2D

const SIZE := GameManager.BALL_SIZE

export var speed := GameManager.BALL_MIN_SPEED
export var min_speed := GameManager.BALL_MIN_SPEED
export var max_speed: = GameManager.BALL_MAX_SPEED
export var speed_increase := GameManager.BALL_INCREASE_SPEED

var velocity: = Vector2.ZERO

func _ready() -> void:
	spawn()
	velocity = Vector2(-0.5 if randf() < 0.5 else 0.5,  0.5)

func _physics_process(delta: float) -> void:
	position += velocity.normalized() * speed * delta

func bounce_paddle(pos: Vector2)->void:
	# check offset for the ball velocity.y
	# the higher it hit the paddle more upward is the angle of the reflection
	# the lower it hit , more downward the angle
	
	var ball_y = global_position.y
	var paddle_y = pos.y
	var contact_y =  ball_y - paddle_y
	velocity.y = contact_y / (GameManager.PADDLE_HEIGHT / 2)
	velocity.x = - velocity.x
	
	speed = clamp(speed + speed_increase, min_speed, max_speed)

func spawn()->void:
	speed = min_speed
	velocity = Vector2.ZERO
	position = GameManager.BALL_SPAWN_POSITION
	velocity = Vector2(-0.5 if randf() < 0.5 else 0.5, 0.5)
