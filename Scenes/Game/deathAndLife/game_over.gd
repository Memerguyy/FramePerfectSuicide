extends Control

var visibleChars := 0

func typeWriter(RTS, speed:float, button, timeout:float) -> void:
	await get_tree().create_timer(0.3).timeout
	while RTS.visible_ratio < 1:
		await get_tree().create_timer(timeout).timeout
		RTS.visible_ratio += speed
		button.disabled = true
		if RTS.visible_ratio == 1:
			button.disabled = false
			return

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	typeWriter($background/RichTextLabel, delta / 12, $background/RichTextLabel/youCantGiveUpYetCanYou,0.1)	
	pass
		


func _on_you_cant_give_up_yet_can_you_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/transition/transToMain.tscn")
	pass # Replace with function body.
