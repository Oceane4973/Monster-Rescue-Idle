extends Control

@onready var money_label = $TopBar/VBoxContainer/Bar/Informations/MoneyIndicator/MarginContainer/VBoxContainer/TotalMoney/MoneyLabel
@onready var prestance_label = $TopBar/VBoxContainer/Bar/Informations/PrestanceIndicator/MarginContainer/HBoxContainer/PrestanceLabel
@onready var nb_monster_label = $TopBar/VBoxContainer/Bar/Informations/MonsterIndicator/MarginContainer/HBoxContainer/MonsterCountLabel

var player_data : PlayerData = null

func _ready():
	player_data = get_node("/root/PlayerData")
	_update_money_label()
	_update_prestance_label()
	_update_nb_monster_label()

func _update_money_label():
	money_label.text = str(player_data.money)

func _update_nb_monster_label():
	nb_monster_label.text = str(player_data.get_total_number_of_monsters())
	
func _update_prestance_label():
	prestance_label.text = str(player_data.prestance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_money_label()
	_update_prestance_label()

