extends Node2D

@onready var plr = $MainChar
@onready var spawner = preload("res://Scenes/Game/spawner.tscn")

func _ready() -> void:
	$spawnSFX.play()
	pass # Replace with function body.


func _process(_delta: float) -> void:
	pass
