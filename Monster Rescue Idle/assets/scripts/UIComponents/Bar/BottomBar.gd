extends Control

@onready var bestBuilding = $BottomBar/Bar/HBoxContainer/BuildingItem
var player_data : PlayerData = null

func _ready():
	player_data = get_node("/root/PlayerData")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var best_building = player_data.get_best_building()
	bestBuilding.load_building_class(best_building)
