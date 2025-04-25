extends Node2D

@onready var enemy = preload("res://Scenes/Humanoids/Enemy/enemy.tscn")

func _ready() -> void:
	$Timer.wait_time = 5.0

func _on_timer_timeout() -> void:
	$Timer.wait_time = 1.0
	var ene = enemy.instantiate()
	get_parent().add_child(ene)
	pass # Replace with function body.
