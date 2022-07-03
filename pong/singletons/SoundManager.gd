extends Node2D

onready var player := $Player

func play_sound(path:String)->void:
	player.stream = load(path)
	player.play()
