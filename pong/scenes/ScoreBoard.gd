extends CanvasLayer

var score := Vector2.ZERO setget set_score

onready var score_left_label := $ScoreContainer/Left
onready var score_right_label := $ScoreContainer/Right

func _ready() -> void:
	EventBus.connect("player_scored", self, "_on_player_scored")

func _on_player_scored(player:String) ->void:
	if player == "left" :
		self.score = Vector2(score.x + 1, score.y)
	else :
		self.score = Vector2(score.x, score.y + 1)

func set_score(value:Vector2)->void :
	score = value
	score_left_label.text = str(score.x)
	score_right_label.text = str(score.y)
	EventBus.emit_signal("score_changed", score)
