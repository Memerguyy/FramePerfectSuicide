extends CharacterBody2D

@onready var enemy = preload("res://Scenes/Humanoids/Enemy/enemy.tscn")

const SPEED = 75.5
const MAX_SPEED = 750.0
const JUMP_VELOCITY = -700.0

var tempDash := 0
var score := 0.0
var floating := false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	print($"../".global_position)
	#scoring
	score += delta * 24
	$Camera2D/score.text = "Your current score is: " + str(snapped(score, 0))
	
	#quit the game ( :C )
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	pass
	
	# Parry mechanic
	if Input.is_action_just_pressed("parry"):
		#sets the floating variable to true which makes the player's velocity (0,0)
		floating = true
		
		#creates a tween for the camera zoom
		var tweenParry = get_tree().create_tween()
		
		#makes the camera zoom
		tweenParry.tween_property($Camera2D, "zoom", Vector2(1.75,1.75), 0.25).set_trans(Tween.TRANS_BACK)
		
		#enables the parry hitbox as well as makes the player piss themselves
		$CollisionBox/Sprite2D.modulate = Color(1, 1, 0.725)
		$Parry/ParryHitbox.disabled = false
		
		#makes the pissing last a whopping .375ms
		await get_tree().create_timer(0.375).timeout
		
		#makes the player not be paused anymore
		floating = false
		
		#self explanatory
		$Parry/ParryHitbox.disabled = true
		
		#for whatever fucking reason, i need to remake the tweener because it wont work any other way.
		#idk
		#idc
		#it works.
		tweenParry = get_tree().create_tween()
		tweenParry.tween_property($Camera2D, "zoom", Vector2(1.25,1.25), 0.2).set_trans(Tween.TRANS_BACK)
		
		var cdreset := 0.725
		while cdreset < 1.0:
			await get_tree().create_timer(0.01).timeout
			cdreset = move_toward(cdreset, 1.0, 0.275/24)
			$CollisionBox/Sprite2D.modulate = Color(1,1,cdreset)

func _physics_process(delta: float) -> void:
	if floating == true:
		$".".velocity = Vector2(0,0)
	elif floating == false:
		if not is_on_floor():
			velocity += get_gravity() * delta*2

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	var direction := Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("ui_right") || Input.is_action_just_pressed("ui_left"):
		$DtTimer.wait_time = 0.2
		$DtTimer.start()

	if $DtTimer.wait_time > 0.1 && Input.is_action_just_pressed("ui_right") || $DtTimer.wait_time > 1 && Input.is_action_just_pressed("ui_left"):
		tempDash += 1
		if tempDash == 2:
			velocity.x += direction * MAX_SPEED*5
			tempDash = 0

	if direction:
		velocity.x += direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 92.5)
		
	if velocity.x > MAX_SPEED || velocity.x < MAX_SPEED * -1:
		velocity.x += (direction*-1) * SPEED*3
		pass

	move_and_slide()


func _on_dt_timer_timeout() -> void:
	tempDash = 0

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		get_tree().change_scene_to_file("res://Scenes/Game/deathAndLife/gameOver.tscn")
	pass # Replace with function body.
