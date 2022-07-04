extends CanvasLayer

var score := 0 setget set_score
var lives := 1 setget set_lives

onready var score_label := $MarginContainer/Box/Scores/Points
onready var lives_label := $MarginContainer/Box/PlayerLives/Lives

func _ready() -> void:
	EventBus.connect("points_scored", self, "_on_points_scored")
	EventBus.connect("ball_missed", self, "_on_ball_missed")

func _on_ball_missed()->void:
	self.lives += 1

func set_lives(value)->void:
	lives = value
	lives_label.text = "%d" % lives

func _on_points_scored(points:int)->void:
	self.score += points

func set_score(value:int)->void:
	score = value
	score_label.text = "%03d" % score
