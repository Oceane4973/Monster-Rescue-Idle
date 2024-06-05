extends Control

@onready var monster_list = get_node("PanelContainer/VBoxContainer/ScrollContainer/MonsterList")
var MonsterItemScene = preload("res://assets/scenes/UIComponents/Items/Monsters/MonsterItem.tscn")
var player_data = null

func _ready():
	player_data = get_node("/root/PlayerData")
	
func instantiate_view():
	for monster in player_data.list_Of_Monsters :
		var instance = MonsterItemScene.instantiate()
		instance.load_monster_class(monster)
		monster_list.add_child(instance)
	
func _on_close_monsters_popup_pressed():
	$MonstersPopupAnimation.play_backwards("popUP")

func _on_monsters_button_pressed():
	$MonstersPopupAnimation.play("popUP")
