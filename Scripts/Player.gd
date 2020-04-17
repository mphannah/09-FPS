extends KinematicBody

onready var Camera = $Pivot/Camera

var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.002
var mouse_range = 1.2
var jumping = false
var jump = 10
var camera_x_rotation = 0

var velocity = Vector3()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("Forward"):
		input_dir += -Camera.global_transform.basis.z
	if Input.is_action_pressed("Back"):
		input_dir += Camera.global_transform.basis.z
	if Input.is_action_pressed("Left"):
		input_dir += -Camera.global_transform.basis.x
	if Input.is_action_pressed("Right"):
		input_dir += Camera.global_transform.basis.x
	if Input.is_action_pressed("Jump"):
		jumping = true
	input_dir = input_dir.normalized()
	return input_dir

func _input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)

func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	
	if (is_on_floor() and jumping):
		velocity.y = jump
	jumping = false
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)


func _on_Area_body_entered(body):
	if body.is_in_group("Enemies"):
		die()

func die():
	queue_free()
	get_tree().change_scene("res://Scenes/GameOver.tscn")
