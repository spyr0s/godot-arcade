class_name Ball
extends Area2D

export var speed := GameManager.BALL_INIT_SPEED
var velocity := Vector2.ZERO


func _ready() -> void:
	EventBus.connect("increase_ball_speed", self, "_on_increase_ball_speed")
	EventBus.connect("ball_missed", self, "_on_ball_missed")
	EventBus.connect("game_started", self, "_on_game_started")
	EventBus.connect("game_resumed", self, "_on_game_resumed")
	EventBus.connect("game_ended", self, "_on_game_ended")

func _on_game_started()->void:
	randomize()
	_spawn_ball()
	
func _on_game_resumed()->void:
	_spawn_ball()	
	
func _on_game_ended()->void:
	_spawn_ball()	
	
func _spawn_ball()->void:
	global_position = GameManager.BALL_INITIAL_POSITION
	speed = GameManager.BALL_INIT_SPEED
	var x = clamp(randf() * 2 - 1.0, -0.75, 0.75)
	velocity = Vector2(x, 1.0)
		
	
func _on_ball_missed()->void:
	GameManager.current_ball_bricks_hit = 0
	GameManager.hit_orange = false
	GameManager.hit_red = false
	global_position = GameManager.BALL_INITIAL_POSITION

func _on_increase_ball_speed()->void:
	speed += speed * GameManager.BALL_INCREASE_SPEED_PERC / 100
	print("Speed: ",speed)

func _physics_process(delta: float) -> void:
	global_position += velocity * speed * delta
