extends Control

@onready var building_list = get_node("PanelContainer/VBoxContainer/ScrollContainer/BuildingsList")
var BuildingItemScene = preload("res://assets/scenes/UIComponents/Items/Buildings/BuildingItem.tscn")
var player_data : PlayerData = null

func _ready():
	player_data = get_node("/root/PlayerData")
	
func instantiate_view():
	for building in player_data.list_Of_Building :
		var instance = BuildingItemScene.instantiate()
		instance.load_building_class(building)
		building_list.add_child(instance)

func _on_close_building_popup_pressed():
	$BuildingPopupAnimation.play_backwards("popUP")

func _on_buildings_button_pressed():
	$BuildingPopupAnimation.play("popUP")
