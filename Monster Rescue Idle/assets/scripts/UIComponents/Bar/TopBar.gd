extends Control

@onready var money_label = $TopBar/VBoxContainer/Bar/Informations/MoneyIndicator/MarginContainer/VBoxContainer/TotalMoney/MoneyLabel
@onready var prestance_label = $TopBar/VBoxContainer/Bar/Informations/PrestanceIndicator/MarginContainer/HBoxContainer/PrestanceLabel

var player_data = null

func _ready():
	player_data = get_node("/root/PlayerData")
	_update_money_label()
	_update_prestance_label()

func _update_money_label():
	money_label.text = str(player_data.money)

func _update_prestance_label():
	prestance_label.text = str(player_data.prestance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_money_label()
	_update_prestance_label()

