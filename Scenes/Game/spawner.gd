extends Node2D

@onready var enemy = preload("res://Scenes/Humanoids/Enemy/enemy.tscn")

func _on_timer_timeout() -> void:
	var ene = enemy.instantiate()
	print("timer done")
	get_parent().add_child(ene)
	pass # Replace with function body.
