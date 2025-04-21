extends Control

var FPS = ["res://Scenes/MainMenu/mainMenuAssets/frame.mp3", "res://Scenes/MainMenu/mainMenuAssets/perfect.mp3", "res://Scenes/MainMenu/mainMenuAssets/suicide.mp3"]
var FPSTXT = ["[font_size=128px][i][b]F-F-FRAME","[center][outline_size=78px][outline_color=black][font_size=96px][code]perfect","[font_size=106px][right][s][b]SUICIDE"]
var i := 0
func _ready() -> void:	
	$FPStext.visible = true
	$FPS.play()
	$FPStext/textBg/FPSTXT.text = FPSTXT[0]


func _on_fps_finished() -> void:
	if i == 2:
		$FPS.stop()
		$FPStext.visible = false
		get_tree().change_scene_to_file("res://Scenes/Game/deathAndLife/main.tscn")
	else:
		i += 1
		$FPS.stream = load(FPS[i])
		$FPS.play()
		$FPStext/textBg/FPSTXT.text = FPSTXT[i]
	pass # Replace with function body.
