extends Node

var bricks_hit := 0
var hit_orange := false
var hit_red := false

const SCREEN_WIDTH = 258
const SCREEN_HEIGHT = 379
const PADDLE_HEIGHT = 6
const WALL_WIDTH = 4
const TOP_MARGIN = 100
const BALL_INIT_SPEED = 150
const BALL_INCREASE_SPEED_PERC = 10

const BRICK_WIDTH = 16
const BRICK_HEIGHT = 4
const BRICK_HOR_GAP = 2
const BRICK_VER_GAP = 2

func _ready() -> void:
	EventBus.connect("brick_hit", self, "_on_brick_hit")

func get_brick_color(row)->Color:
	if row < 2 :
		return Color.red
	elif row < 4 :
		return Color.orange
	elif row < 6 :
		return Color.green
	return Color.yellow

func _on_brick_hit(color:Color)->void:
	bricks_hit += 1
	# Increase speed after 4 and 12 hits
	if bricks_hit == 4  or bricks_hit == 12:
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
