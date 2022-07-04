class_name Ball
extends Area2D

export var speed := GameManager.BALL_INIT_SPEED
var velocity := Vector2.ZERO


func _ready() -> void:
	speed = GameManager.BALL_INIT_SPEED
	var x = clamp(randf() - 1.0, -0.5, 0.5)
	velocity = Vector2(x, 1.0)
	EventBus.connect("increase_ball_speed", self, "_on_increase_ball_speed")
	EventBus.connect("ball_missed", self, "_on_ball_missed")

func _on_ball_missed()->void:
	queue_free()

func _on_increase_ball_speed()->void:
	speed += speed * GameManager.BALL_INCREASE_SPEED_PERC / 100

func _physics_process(delta: float) -> void:
	global_position += velocity * speed * delta
