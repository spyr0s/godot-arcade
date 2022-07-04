extends Area2D

export var width := 18

onready var rect := $ColorRect
onready var collision := $CollisionShape2D

func _ready() -> void:
	rect.rect_position = Vector2(-width / 2, - GameManager.PADDLE_HEIGHT / 2)
	rect.rect_min_size = Vector2(width, GameManager.PADDLE_HEIGHT)
	var shape = collision.shape as RectangleShape2D
	shape.extents = Vector2(width/2, GameManager.PADDLE_HEIGHT/2)

func _physics_process(delta: float) -> void:

	var mouse_position = get_global_mouse_position()
	var min_position = GameManager.WALL_WIDTH + width / 2
	var max_position = GameManager.SCREEN_WIDTH - GameManager.WALL_WIDTH - width / 2
	position.x = clamp(mouse_position.x, min_position, max_position)


func _on_Paddle_area_entered(area: Area2D) -> void:
	if area is Ball:
		var ball = area as Ball
		var ball_x = ball.global_position.x
		var paddle_x = global_position.x
		var contact_x =  ball_x - paddle_x
		ball.velocity.x = contact_x / (width / 2)
		ball.velocity.y = -ball.velocity.y
