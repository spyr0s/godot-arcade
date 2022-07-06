extends Node2D


onready var brick_scene = preload("res://scenes/Brick.tscn")
onready var bricks := $Bricks

func _ready() -> void:
	randomize()
	_add_bricks()
	EventBus.connect("game_started", self, "_on_game_started")
	EventBus.connect("level_cleared", self, "_on_level_cleared")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_level_cleared()->void:
	_add_bricks()

func _on_game_started()->void:
	_add_bricks()
	
func _add_bricks()->void:
	for brick in bricks.get_children() :
		brick.queue_free()
	for row in range(8) :
		for column in range(14) :
			var brick = brick_scene.instance()
			var x_position = GameManager.WALL_WIDTH + GameManager.BRICK_WIDTH / 2  + column * (GameManager.BRICK_WIDTH + GameManager.BRICK_HOR_GAP)
			var y_position = GameManager.TOP_MARGIN + GameManager.BRICK_HEIGHT / 2 + row * (GameManager.BRICK_HEIGHT + GameManager.BRICK_VER_GAP)
			brick.color = GameManager.get_brick_color(row)
			brick.global_position = Vector2(x_position, y_position)
			if randf() <= GameManager.BRICKS_COVERAGE / 100 :
				bricks.add_child(brick)

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if GameManager.status == GameManager.Status.IDLE :
			EventBus.emit_signal("game_started")
		elif GameManager.status == GameManager.Status.LOST_BALL :
			EventBus.emit_signal("game_resumed")	
		elif GameManager.status == GameManager.Status.LEVEL_CLEARED :
			EventBus.emit_signal("game_resumed")		
			
func _physics_process(delta):
	if bricks.get_child_count() == 0 :
		EventBus.emit_signal("level_cleared")
