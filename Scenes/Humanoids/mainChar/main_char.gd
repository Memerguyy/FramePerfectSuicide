extends CharacterBody2D

const SPEED = 75.5
const MAX_SPEED = 750.0
const JUMP_VELOCITY = -700.0

var tempDash := 0

func _process(_delta: float) -> void:	
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	pass
	
	# Parry mechanic
	if Input.is_action_just_pressed("parry"):
		var tweenParry = get_tree().create_tween()
		$Hitbox/Sprite2D.modulate = Color(1, 1, 0.725)
		$Parry/ParryHitbox.disabled = false
		print("parry?")
		
		await get_tree().create_timer(0.375).timeout
		tweenParry.stop()
		$Parry/ParryHitbox.disabled = true
		print("parry time over")
		
		var cdreset := 0.725
		while cdreset < 1.0:
			await get_tree().create_timer(0.01).timeout
			cdreset = move_toward(cdreset, 1.0, 0.275/24)
			$Hitbox/Sprite2D.modulate = Color(1,1,cdreset)

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta*2

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	var direction := Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("ui_right") || Input.is_action_just_pressed("ui_left"):
		$DtTimer.wait_time = 0.2
		$DtTimer.start()

	if $DtTimer.wait_time > 0.1 && Input.is_action_just_pressed("ui_right") || $DtTimer.wait_time > 0.1 && Input.is_action_just_pressed("ui_left"):
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

#func _on_parry_area_entered(area: Area2D) -> void:
	#pass # Replace with function body.
