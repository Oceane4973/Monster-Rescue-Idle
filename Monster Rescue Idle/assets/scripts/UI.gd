extends CanvasLayer
class_name UI

@onready var money_label = $Control/GlobalMargin/TopBar/VBoxContainer/Bar/Informations/MoneyIndicator/MarginContainer/VBoxContainer/TotalMoney/MoneyLabel
@onready var prestance_label = $Control/GlobalMargin/TopBar/VBoxContainer/Bar/Informations/PrestanceIndicator/MarginContainer/HBoxContainer/PrestanceLabel

var money = 0:
	set(new_money):
		money = new_money
		_update_money_label()

func _update_money_label():
	money_label.text = str(money)
	
var prestance = 0:
	set(new_prestance):
		prestance = new_prestance
		_update_prestance_label()

func _update_prestance_label():
	prestance_label.text = str(prestance)

# Called when the node enters the scene tree for the first time.
func _ready():
	_update_money_label()
	_update_prestance_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#pass
	prestance += 1
	money += 1
	
	



func _on_setting_button_pressed():
		$Control/SettingsPopup/SettingsPopupAnimation.play("popup")

func _on_close_settings_popup_pressed():
	$Control/SettingsPopup/SettingsPopupAnimation.play_backwards("popup")
