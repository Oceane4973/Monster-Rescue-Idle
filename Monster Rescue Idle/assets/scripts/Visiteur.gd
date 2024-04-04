class_name Visiteur
extends Sprite3D

var camera = null
var points: int = 0

func _set_camera(c):
	camera = c

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	points += 1
	pass

func save():
	var value = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y,
		"pos_z" : position.z,
		"points" : points
	}
	return value
