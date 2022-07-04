extends Node2D


onready var brick_scene = preload("res://scenes/Brick.tscn")
onready var bricks := $Bricks

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	_add_bricks()

func _add_bricks()->void:
	for row in range(8) :
		for column in range(14) :
			var brick = brick_scene.instance()
			var x_position = GameManager.WALL_WIDTH + GameManager.BRICK_WIDTH / 2  + column * (GameManager.BRICK_WIDTH + GameManager.BRICK_HOR_GAP)
			var y_position = GameManager.TOP_MARGIN + GameManager.BRICK_HEIGHT / 2 + row * (GameManager.BRICK_HEIGHT + GameManager.BRICK_VER_GAP)
			brick.color = GameManager.get_brick_color(row)
			brick.global_position = Vector2(x_position, y_position)
			bricks.add_child(brick)
