extends Control

@onready var money_label = $TopBar/VBoxContainer/Bar/Informations/MoneyIndicator/MarginContainer/VBoxContainer/TotalMoney/MoneyLabel
@onready var prestance_label = $TopBar/VBoxContainer/Bar/Informations/PrestanceIndicator/MarginContainer/HBoxContainer/PrestanceLabel
@onready var monster_label = $TopBar/VBoxContainer/Bar/Informations/MonsterIndicator/MarginContainer/HBoxContainer/MonsterCountLabel
@onready var rotate_icon = $TopBar/VBoxContainer/LockRotationButton/MarginContainer/LockRotation/Icon

var player_data = null
var ui_data = null

func _ready():
	player_data = get_node("/root/PlayerData")
	ui_data = get_node("/root/UiData");
	_update_money_label()
	_update_prestance_label()

func _update_money_label():
	money_label.text = str(player_data.money)

func _update_prestance_label():
	prestance_label.text = str(player_data.prestance)

func _update_rotate_icon():
	if ui_data.rotating == true:
		rotate_icon.texture = load("res://assets/textures/rotation.png")
	else:
		rotate_icon.texture = load("res://assets/textures/not_rotation.png")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_money_label();
	_update_prestance_label();
	_update_rotate_icon();
	monster_label.text = JSON.stringify(player_data.points) + "\n" + str(player_data.zoom)

