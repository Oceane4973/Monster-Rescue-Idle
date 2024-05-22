extends Node3D

# Référence : https://finepointcgi.io/2023/06/16/building-a-touchscreen-camera-in-godot-4-a-comprehensive-guide/

@export var rotation_speed = PI / 2
@export var max_zoom = 8.0
@export var min_zoom = 3.0
@export var zoom_speed = 0.1
@export var max_x_rotation = 0.3
@export var min_x_rotation = -1
var start_dist: float
var touch_points: Dictionary = {}
var current_delta = 0;

var zoom = 8.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#get_input_keyboard(delta)
	current_delta = delta;

func _handle_touch(event: InputEventScreenTouch):
	if event.pressed:
		touch_points[event.index] = event.position
	else:
		touch_points.erase(event.index)
	#if touch_points.size() == 2:
	#	var touch_point_positions = touch_points.values()
	#	start_dist = touch_point_positions[0].distance_to(touch_point_positions[1])
	#	start_dist = 0
	#return

func _handle_drag(event: InputEventScreenDrag):
	touch_points[event.index] = event.position
	if touch_points.size() == 1:
		# Référence : https://www.youtube.com/watch?v=5Kjw8_JNPv8
		var x_rotation = event.relative.y * 0.05
		var y_rotation = event.relative.x * 0.05
		rotateCamera(y_rotation, x_rotation, current_delta)
	# Handle 2 touch points
	#if touch_points.size() == 2:
	#	var touch_point_positions = touch_points.values()
	#	var current_dist = touch_point_positions[0].distance_to(touch_point_positions[1])
	#	var zoom_factor = start_dist / current_dist
	#	zoom = zoom / zoom_factor

func _input(event):
	if event is InputEventScreenTouch:
		_handle_touch(event)
	elif event is InputEventScreenDrag:
		_handle_drag(event)

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
	var x_rotation = 0
	if Input.is_action_pressed("cam_up"):
		x_rotation += 1
	if Input.is_action_pressed("cam_down"):
		x_rotation -= 1
	print("Vérif")
	rotateCamera(y_rotation, x_rotation, delta)

func rotateCamera(y_rotation, x_rotation, factor_value: float):
	rotate_y(y_rotation * rotation_speed * factor_value)
	$Centre.rotate_x(x_rotation * rotation_speed * factor_value)
	if($Centre.rotation.x < min_x_rotation):
		$Centre.rotation.x = min_x_rotation
	if($Centre.rotation.x > max_x_rotation):
		$Centre.rotation.x = max_x_rotation


