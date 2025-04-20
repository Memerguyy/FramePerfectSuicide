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
	

var FPS = ["res://Scenes/MainMenu/mainMenuAssets/frame.mp3", "res://Scenes/MainMenu/mainMenuAssets/perfect.mp3", "res://Scenes/MainMenu/mainMenuAssets/suicide.mp3"]
var FPSTXT = ["[font_size=128px][i][b]F-F-FRAME","[center][outline_size=78px][outline_color=black][font_size=96px][code]perfect","[font_size=106px][right][s][b]SUICIDE"]
var i := 0
func _on_button_pressed() -> void:
	$bgm.stop()
	$FPStext.visible = true
	$FPS.play()
	$FPStext/textBg/FPSTXT.text = FPSTXT[0]
	#$FPS.stream.resource_path = "res://Scenes/MainMenu/mainMenuAssets/perfect.mp3"
	#print($FPS.stream.resource_path)
	#get_tree().change_scene_to_file("res://Scenes/Game/main.tscn")
	pass # Replace with function body.


func _on_fps_finished() -> void:
	print("ASIOKJFJKHASHJKF")
	if i == 2:
		$FPS.stop()
		get_tree().change_scene_to_file("res://Scenes/Game/main.tscn")
	else:
		i += 1
		$FPS.stream = load(FPS[i])
		$FPS.play()
		$FPStext/textBg/FPSTXT.text = FPSTXT[i]
		pass # Replace with function body.


func _on_bgm_ready() -> void:
	$bgm.play()
	pass # Replace with function body.
