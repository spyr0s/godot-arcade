extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_TopWall_area_entered(area: Area2D) -> void:
	_bounce_on_wall(area)

func _on_BottomWall_area_entered(area: Area2D) -> void:
	_bounce_on_wall(area)

func _on_LeftGoal_area_entered(area: Area2D) -> void:
	SoundManager.play_sound("res://assets/sounds/score.ogg")
	EventBus.emit_signal("player_scored","right")

func _on_RightGoal_area_entered(area: Area2D) -> void:
	SoundManager.play_sound("res://assets/sounds/score.ogg")
	EventBus.emit_signal("player_scored","left")
	
func _bounce_on_wall(area: Area2D)->void:
	if area.is_in_group("ball"):
		area.velocity.y = -area.velocity.y
		SoundManager.play_sound("res://assets/sounds/hit_wall.ogg")
