extends CanvasLayer

export var max_lives := 3

var score := 0 setget set_score
var remaining_lives := 3 setget set_remaining_lives

onready var score_label := $MarginContainer/Box/Scores/Points
onready var lives_label := $MarginContainer/Box/PlayerLives/Lives
onready var instructions_label := $MarginContainer/Box/Label

func _ready() -> void:
	EventBus.connect("points_scored", self, "_on_points_scored")
	EventBus.connect("ball_missed", self, "_on_ball_missed")
	EventBus.connect("game_started", self, "_on_game_started")
	EventBus.connect("game_ended", self, "_on_game_ended")

func _on_game_started()->void:
	self.score = 0
	self.remaining_lives = 3
	instructions_label.hide()
	
func _on_game_ended()->void:
	instructions_label.show()
	
func _on_ball_missed()->void:
	if remaining_lives == 1 :
		EventBus.emit_signal("game_ended")		
	else :
		self.remaining_lives -= 1
	
func set_remaining_lives(value)->void:
	remaining_lives = value
	lives_label.text = "%d" % (max_lives - remaining_lives + 1)

func _on_points_scored(points:int)->void:
	if GameManager.status == GameManager.Status.PLAYING :	
		self.score += points

func set_score(value:int)->void:
	score = value
	score_label.text = "%03d" % score
