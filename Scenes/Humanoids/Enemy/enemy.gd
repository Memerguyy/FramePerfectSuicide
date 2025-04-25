extends CharacterBody2D

#@onready var mainPlr = "res://Scenes/Humanoids/mainChar/$"../MainChar".tscn"

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var pxTillPlr

func _ready() -> void:
	$".".global_position.y = $"../MainChar".position.y
	$".".global_position.x = $"../MainChar".position.x + RandomNumberGenerator.new().randi_range(-1000, 1000)
	pass
func _process(delta: float) -> void:
	pxTillPlr = $".".position.distance_to($"../MainChar".position)
	
	if Globals.isEnemyPaused == true:
		$".".process_mode =Node.PROCESS_MODE_PAUSABLE
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if pxTillPlr != 0:
		$".".position.x += 5.5 * snappedi(($".".position.direction_to($"../MainChar".position)).x,1)
	# make an if condition to where it just fucking checks if the enemy is inside of the player, if it isnt, move that ass towards him idfk
	move_and_slide()


func _on_collision_box_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Parry") || area.is_in_group("Attack"):
		print("parried!")
		$".".queue_free()
	pass # Replace with function body.
