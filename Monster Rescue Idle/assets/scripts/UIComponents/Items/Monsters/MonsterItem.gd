extends PanelContainer

@export var name_node: Node
@export var description_node: Node
@export var benefice_node: Node
@export var price_node: Node
@export var ratio_nb_node: Node
@export var img: Node

@onready var buyButtonSell = $HBoxContainer/BuyButton/MarginContainer/PossibleSell
@onready var buyButtonBloqued = $HBoxContainer/BuyButton/MarginContainer/LockedSell
@onready var buyButtonPanel = $HBoxContainer/BuyButton

var white_color = Color(1, 1, 1)
var gray_color = Color(0.8, 0.8, 0.8)

var monster : Monster = null
var player_data : PlayerData = null
var ui_data : UiData = null

func _ready():
	player_data = get_node("/root/PlayerData")
	ui_data = get_node("/root/UiData")
	
func load_monster_class(the_monster : Monster):
	monster = the_monster
	if monster != null :
		name_node.text = monster.name
		description_node.text = monster.description
		benefice_node.text = ('+' + str(monster.benefice))
		price_node.text = ("" + str(monster.price))
		ratio_nb_node.text = (str(monster.currentNB) + '/' + str(monster.maxNB))
		var texture = load(monster.img_src) 
		if texture != null :
			img.texture = texture
	

func change_panel_container_color(new_color: Color) -> void:
	buyButtonPanel.modulate = new_color
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_view()

func update_view():
	if monster.is_bloqued():
		buyButtonBloqued.visible = true
		buyButtonSell.visible = false
		change_panel_container_color(gray_color)
	else:
		if monster.currentNB < monster.maxNB : 
			if monster.price > player_data.money:
				change_panel_container_color(gray_color)
			else:
				change_panel_container_color(white_color)
			buyButtonBloqued.visible = false
			buyButtonSell.visible = true
		else : 
			$HBoxContainer/BuyButton/MarginContainer/LockedSell/MoneyPerSec/Label.text = "MAX."
			buyButtonBloqued.visible = true
			buyButtonSell.visible = false
			change_panel_container_color(gray_color)

func _on_buy_button_pressed():
	if monster.is_bloqued() == false and monster.price <= player_data.money and monster.currentNB < monster.maxNB:
		player_data.money -= monster.price
		player_data.money_per_sec += monster.benefice
		monster.currentNB += 1
		monster.price = monster.price * 1.6
		monster.benefice = monster.benefice * 1.3
		load_monster_class(monster)
		update_view()
		_add_monster(monster)
		
func _add_monster(monster : Monster):
	var assets = load(monster.model_src).instantiate();
	var suivi_chemin: PathFollow3D = PathFollow3D.new()
	var value_progress: float = randi_range(0, 100)
	suivi_chemin.progress = value_progress
	suivi_chemin.loop = true;
	suivi_chemin.add_child(assets)
	ui_data.chemin.add_child(suivi_chemin)
