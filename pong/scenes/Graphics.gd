extends Control

export var game_end_score := GameManager.GAME_END_SCORE

onready var stripes_container := $StripesContainer
onready var stripe := preload("res://scenes/Stripe.tscn")

onready var end_game := $Margin/EndGame
onready var winner_label := $Margin/EndGame/Winner

func _ready():
	end_game.hide()
	for i in range(30) :
		stripes_container.add_child(stripe.instance(), true)
	
	EventBus.connect("game_ended", self, "_on_game_ended")
	EventBus.connect("score_changed", self, "_on_score_changed")	

func _on_game_ended(winner:String)->void:
	winner_label.text = "Player %s wins" % ("1" if winner == "left" else "2")
	end_game.show()

func _on_Button_button_up() -> void:
	get_tree().reload_current_scene()

func _on_score_changed(score:Vector2)->void:
	if score.x >= game_end_score :
		EventBus.emit_signal("game_ended", "left")
	elif score.y >= game_end_score :
		EventBus.emit_signal("game_ended", "right")
	else :
		EventBus.emit_signal("spawn_ball")
