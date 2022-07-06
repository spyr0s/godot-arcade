extends Area2D

export var width := 18

onready var rect := $ColorRect
onready var collision := $CollisionShape2D

func _ready() -> void:
	_on_game_started()
	EventBus.connect("game_ended", self, "_on_game_ended")
	EventBus.connect("game_started", self, "_on_game_started")

func _on_game_ended()->void:
	_resize_paddle(GameManager.SCREEN_WIDTH)
	
func _on_game_started()->void:
	_resize_paddle(width)
	
func _resize_paddle(width:float)->void :
	position = Vector2(GameManager.PADDLE_POSITION)
	rect.rect_position = Vector2(-width / 2, - GameManager.PADDLE_HEIGHT / 2)
	rect.rect_min_size = Vector2(width, GameManager.PADDLE_HEIGHT)
	rect.rect_size = Vector2(width, GameManager.PADDLE_HEIGHT)	
	var shape = collision.shape as RectangleShape2D
	shape.extents = Vector2(width/2, GameManager.PADDLE_HEIGHT/2)

func _physics_process(delta: float) -> void:
	_move_paddle(delta)
	
func _move_paddle(delta)->void:
	if GameManager.status == GameManager.Status.IDLE :
		return
	var mouse_position = get_global_mouse_position()
	var min_position = GameManager.WALL_WIDTH + width / 2
	var max_position = GameManager.SCREEN_WIDTH - GameManager.WALL_WIDTH - width / 2
	position.x = clamp(mouse_position.x, min_position, max_position)


func _on_Paddle_area_entered(area: Area2D) -> void:
	if area is Ball:
		var ball = area as Ball
		if GameManager.status == GameManager.Status.IDLE :
			ball.velocity.y = -ball.velocity.y
			return
		var ball_x = ball.global_position.x
		var paddle_x = global_position.x
		var contact_x =  ball_x - paddle_x
		ball.velocity.x = contact_x / (width / 2)
		ball.velocity.y = -ball.velocity.y
