extends Node2D

#@onready var plr = $MainChar
@onready var enemy = preload("res://Scenes/Humanoids/Enemy/enemy.tscn")

func _ready() -> void:
	$spawnSFX.play()
	pass # Replace with function body.
