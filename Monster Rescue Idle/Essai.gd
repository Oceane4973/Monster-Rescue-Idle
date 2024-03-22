extends Node3D

@export var rotation_speed = PI / 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input_keyboard(delta)

func get_input_keyboard(delta):
	var y_rotation = 0
	if Input.is_action_pressed("cam_right"):
		y_rotation += 1
	if Input.is_action_pressed("cam_left"):
		y_rotation -= 1
	rotate_object_local(Vector3.UP, y_rotation * rotation_speed * delta)
	var x_rotation = 0
	if Input.is_action_pressed("cam_up"):
		x_rotation += 1
	if Input.is_action_pressed("cam_down"):
		x_rotation -= 1
	#rotate_object_local(Vector3.RIGHT, x_rotation * rotation_speed * delta)
	$Espace.rotate_object_local(Vector3.RIGHT, x_rotation * rotation_speed * delta)
	if($Espace.rotation.x < -1):
		$Espace.rotation.x = -1
	if($Espace.rotation.x > 0.5):
		$Espace.rotation.x = 0.5
	print( $Espace.rotation)
