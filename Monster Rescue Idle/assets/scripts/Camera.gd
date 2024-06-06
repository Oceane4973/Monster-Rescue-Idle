extends Node3D

# Référence : https://finepointcgi.io/2023/06/16/building-a-touchscreen-camera-in-godot-4-a-comprehensive-guide/

@export var rotation_speed = PI / 2
@export var max_zoom = 8.0
@export var min_zoom = 3.0
@export var zoom_speed = 0.1
@export var max_x_rotation = 0.3
@export var min_x_rotation = -1
@export var min_y_translation = -8
@export var max_y_translation = 16
@export var min_xz_translation = -48
@export var max_xz_translation = 48
var start_dist: float
var touch_points: Dictionary = {}
var current_delta = 0;

var zoom = 8.0

var player_data = null
var ui_data = null

# Called when the node enters the scene tree for the first time.
func _ready():
	player_data = get_node("/root/PlayerData")
	ui_data = get_node("/root/UiData");
	#rotate_object_local(Vector3.UP, 0)
	#$Centre.rotate_object_local(Vector3.RIGHT, 0)
	scale = Vector3.ONE * zoom
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input_keyboard()
	current_delta = delta;

func _handle_touch(event: InputEventScreenTouch):
	if event.pressed:
		touch_points[event.index] = event.position
	else:
		touch_points.erase(event.index)
	if touch_points.size() == 2:
		var touch_point_positions = touch_points.values()
		start_dist = touch_point_positions[0].distance_to(touch_point_positions[1])
		start_dist = 0

func _handle_drag(event: InputEventScreenDrag):
	touch_points[event.index] = event.position
	player_data.points = touch_points;
	if touch_points.size() == 1:
		if ui_data.rotating == true:
			# Référence : https://www.youtube.com/watch?v=5Kjw8_JNPv8
			var x_rotation = event.relative.y * 0.05
			var y_rotation = event.relative.x * 0.05
			rotateCamera(-y_rotation, -x_rotation)
		else:
			var x_translation = event.relative.x * 0.005
			var y_translation = event.relative.y * 0.005
			translateCamera(-x_translation, y_translation);
	# Handle 2 touch points
	#if touch_points.size() == 2:
	#	var touch_point_positions = touch_points.values()
	#	var current_dist = touch_point_positions[0].distance_to(touch_point_positions[1])
	#	var zoom_factor = start_dist / current_dist
	#	zoom = zoom / zoom_factor
	#	zoomCamera();

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
	zoomCamera();

func get_input_keyboard():
	var x_translation = 0
	if Input.is_action_pressed("cam_right"):
		x_translation += 1
	if Input.is_action_pressed("cam_left"):
		x_translation -= 1
	var y_translation = 0
	if Input.is_action_pressed("cam_up"):
		y_translation += 1
	if Input.is_action_pressed("cam_down"):
		y_translation -= 1
	if(x_translation != 0 || y_translation != 0):
		translateCamera(x_translation, y_translation)

func rotateCamera(y_rotation, x_rotation):
	rotate_y(y_rotation * rotation_speed * current_delta)
	$Centre.rotate_x(x_rotation * rotation_speed * current_delta)
	if($Centre.rotation.x < min_x_rotation):
		$Centre.rotation.x = min_x_rotation
	if($Centre.rotation.x > max_x_rotation):
		$Centre.rotation.x = max_x_rotation

func translateCamera(x_translation, y_translation):
	translate(Vector3(x_translation, y_translation, 0.0));
	if(transform.origin.y < min_y_translation):
		transform.origin.y = min_y_translation;
	if(transform.origin.y > max_y_translation):
		transform.origin.y = max_y_translation;
	if(transform.origin.x < min_xz_translation):
		transform.origin.x = min_xz_translation;
	if(transform.origin.z < min_xz_translation):
		transform.origin.z = min_xz_translation;
	if(transform.origin.x > max_xz_translation):
		transform.origin.x = max_xz_translation;
	if(transform.origin.z > max_xz_translation):
		transform.origin.z = max_xz_translation;

func zoomCamera():
	zoom = clamp(zoom, min_zoom, max_zoom)
	player_data.zoom = zoom
	scale = Vector3.ONE * zoom
