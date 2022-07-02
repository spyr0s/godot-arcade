extends Node2D

export var game_end_score := 5

onready var stripes_container := $Background/StripesContainer
onready var stripe := preload("res://Scenes/Stripe.tscn")
onready var end_game := $Background/Margin/EndGame
onready var winner_label := $Background/Margin/EndGame/Winner
onready var ball := $Ball


func _ready() -> void:
	randomize()
	end_game.hide()
	EventBus.connect("game_ended", self, "_on_game_ended")
	EventBus.connect("score_changed", self, "_on_score_changed")

	for i in range(30) :
		stripes_container.add_child(stripe.instance(), true)

func _on_score_changed(score:Vector2)->void:
	if score.x >= game_end_score :
		EventBus.emit_signal("game_ended", "left")
	elif score.y >= game_end_score :
		EventBus.emit_signal("game_ended", "right")
	else :
		ball.spawn()

func _on_game_ended(winner:String)->void:
	winner_label.text = "Player %s wins" % ("1" if winner == "left" else "2")
	end_game.show()

func _on_BottomWall_area_entered(area: Area2D) -> void:
	_bounce_on_wall(area)

func _on_TopWall_area_entered(area: Area2D) -> void:
	_bounce_on_wall(area)

func _bounce_on_wall(area: Area2D)->void:
	if area.is_in_group("ball"):
		area.velocity.y = -area.velocity.y

func _on_LeftGoal_area_entered(area: Area2D) -> void:
	EventBus.emit_signal("player_scored","right")

func _on_RightGoal_area_entered(area: Area2D) -> void:
	EventBus.emit_signal("player_scored","left")

func _on_Button_button_up() -> void:
	get_tree().reload_current_scene()
