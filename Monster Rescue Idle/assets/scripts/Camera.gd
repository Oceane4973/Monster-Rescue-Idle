extends Node3D

# Référence : https://www.youtube.com/watch?app=desktop&v=4NLrfxNt3ps

@export var rotation_speed = PI / 2
@export var max_zoom = 8.0
@export var min_zoom = 3.0
@export var zoom_speed = 0.1

var zoom = 8.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input_keyboard(delta)

func _unhandled_input(event):
	if event.is_action_pressed("cam_zoom_in"):
		zoom -= zoom_speed
	if event.is_action_pressed("cam_zoom_out"):
		zoom += zoom_speed
	zoom = clamp(zoom, min_zoom, max_zoom)
	scale = Vector3.ONE * zoom

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
	$Centre.rotate_object_local(Vector3.RIGHT, x_rotation * rotation_speed * delta)
	if($Centre.rotation.x < -1):
		$Centre.rotation.x = -1
	if($Centre.rotation.x > 0.3):
		$Centre.rotation.x = 0.3
