extends Node2D

var invRotate := false
var screenChange := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween := get_tree().create_tween()
	print($RichTextLabel.rotation_degrees)
	tween.set_loops(0)
	tween.tween_property($RichTextLabel, "rotation_degrees", 10, 2.0).set_ease(Tween.EASE_IN_OUT).set_trans(1)
	tween.tween_property($RichTextLabel, "rotation_degrees", -10, 2.0).set_ease(Tween.EASE_IN_OUT).set_trans(1)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	screenChange += delta
	#print(screenChange)
	if screenChange > 0.9:
		$waitingRoom.color = Color(1, 1, 1)
		var tweenScreen := get_tree().create_tween()
		tweenScreen.tween_property($waitingRoom, "color", Color(1, 1, 1, 0), 1.3).set_ease(Tween.EASE_IN_OUT)
	pass
	


func _on_button_pressed() -> void:
#	TODO: MOVE THIS TO THE _ready OF main.tscn
	$bgm.stop()
	get_tree().change_scene_to_file("res://Scenes/Game/transition/transToMain.tscn")
	
	#$FPS.stream.resource_path = "res://Scenes/MainMenu/mainMenuAssets/perfect.mp3"
	#print($FPS.stream.resource_path)
	#get_tree().change_scene_to_file("res://Scenes/Game/main.tscn")
	pass # Replace with function body.

func _on_bgm_ready() -> void:
	$bgm.play()
	pass # Replace with function body.
