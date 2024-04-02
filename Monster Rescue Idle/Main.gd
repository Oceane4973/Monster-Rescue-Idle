extends Area3D

const move_speed := 4.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	$CheminVisiteurs/SuiviChemin.progress += move_speed * delta
