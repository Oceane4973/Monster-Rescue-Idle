extends Control

@onready var monster_list = get_node("PanelContainer/VBoxContainer/ScrollContainer/MonsterList")
@onready var nb_monsters = $PanelContainer/VBoxContainer/PanelContainer/HBoxContainer2/NbMonsters
var MonsterItemScene = preload("res://assets/scenes/UIComponents/Items/Monsters/MonsterItem.tscn")
var player_data : PlayerData = null

func _ready():
	player_data = get_node("/root/PlayerData")

func _process(delta):
	nb_monsters.text = str(player_data.get_total_number_of_monsters()) + "/" + str(player_data.get_possible_total_number_of_monsters())
	
func instantiate_view():
	for monster in player_data.list_Of_Monsters :
		var instance = MonsterItemScene.instantiate()
		instance.load_monster_class(monster)
		monster_list.add_child(instance)

func _on_close_monsters_popup_pressed():
	$MonstersPopupAnimation.play_backwards("popUP")

func _on_monsters_button_pressed():
	$MonstersPopupAnimation.play("popUP")
