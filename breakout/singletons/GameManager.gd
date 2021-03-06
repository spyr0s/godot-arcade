extends Node

enum Status {
	IDLE,
	PLAYING,
	LOST_BALL,
	LEVEL_CLEARED
}
var bricks_hit := 0
var current_ball_bricks_hit := 0
var hit_orange := false
var hit_red := false
var status :int = Status.IDLE 
var level := 1
var max_levels := 2

const BRICKS_COVERAGE := 100.0

const SCREEN_WIDTH = 258
const SCREEN_HEIGHT = 379
const PADDLE_HEIGHT = 6
const WALL_WIDTH = 4
const TOP_MARGIN = 100
const BALL_INIT_SPEED = 180
const BALL_INCREASE_SPEED_PERC = 10
const MAX_BALLS := 3

const PADDLE_POSITION = Vector2(SCREEN_WIDTH / 2, 351)
const BALL_INITIAL_POSITION = Vector2(129, 170)

const BRICK_WIDTH = 16
const BRICK_HEIGHT = 4
const BRICK_HOR_GAP = 2
const BRICK_VER_GAP = 2

func _ready() -> void:
	EventBus.connect("brick_hit", self, "_on_brick_hit")
	EventBus.connect("game_started", self, "_on_game_started")
	EventBus.connect("ball_missed", self, "_on_ball_missed")
	EventBus.connect("game_resumed", self, "_on_game_resumed")
	EventBus.connect("game_ended", self, "_on_game_ended")
	EventBus.connect("level_cleared", self, "_on_level_cleared")
	
func get_brick_color(row)->Color:
	if row < 2 :
		return Color.red
	elif row < 4 :
		return Color.orange
	elif row < 6 :
		return Color.green
	return Color.yellow

func _on_game_started()->void:
	status = Status.PLAYING
	
func _on_ball_missed()->void:
	status = Status.LOST_BALL
	
func _on_game_resumed()->void:
	status = Status.PLAYING

func _on_game_ended()->void:
	status = Status.IDLE	
	
func _on_level_cleared()->void:
	level += 1
	if level <= max_levels :
		status = Status.LEVEL_CLEARED
	else :
		EventBus.emit_signal("game_ended")
		
func _on_brick_hit(color:Color)->void:
	bricks_hit += 1
	current_ball_bricks_hit += 1
	# Increase speed after 4 and 12 hits
	if current_ball_bricks_hit == 4  or current_ball_bricks_hit == 12:
		EventBus.emit_signal("increase_ball_speed")
	# Increase speed after first orange brick hit
	if color == Color.orange and not hit_orange :
		EventBus.emit_signal("increase_ball_speed")
		hit_orange = true
	# Increase speed after first red brick hit
	if color == Color.red and not hit_red :
		EventBus.emit_signal("increase_ball_speed")
		hit_red = true
	var points = _get_points(color)
	EventBus.emit_signal("points_scored", points)

func _get_points(color: Color)->int :
	match color :
		Color.yellow :
			return 1
		Color.green :
			return 3
		Color.orange :
			return 5
		Color.red :
			return 7
	return 0
