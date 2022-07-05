extends Node2D

onready var ball := $Ball

func _ready() -> void:
	randomize()
	EventBus.connect("game_ended", self, "_on_game_ended")
	EventBus.connect("spawn_ball", self, "_on_spawn_ball")
	
func _on_spawn_ball()->void:
	ball.spawn()

func _on_game_ended(winner:String)->void:
	ball.queue_free()
