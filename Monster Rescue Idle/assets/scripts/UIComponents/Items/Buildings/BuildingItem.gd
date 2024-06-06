extends PanelContainer

@export var name_node: Node
@export var description_node: Node
@export var benefice_node: Node
@export var price_node: Node
@export var niv_node: Node
@export var img: Node

@onready var buyButtonSell = $MarginContainer/HBoxContainer/BuyButton/MarginContainer/PossibleSell
@onready var buyButtonBloqued = $MarginContainer/HBoxContainer/BuyButton/MarginContainer/LockedSell
@onready var buyButtonPanel = $MarginContainer/HBoxContainer/BuyButton

var white_color = Color(1, 1, 1)
var gray_color = Color(0.8, 0.8, 0.8)

var building : Building = null
var player_data = null

func _ready():
	player_data = get_node("/root/PlayerData")
	
func load_building_class(the_building : Building):
	building = the_building
	if building != null :
		name_node.text = building.name
		description_node.text = building.description
		benefice_node.text = ('+' + str(building.benefice) + '/sec')
		price_node.text = ("" + str(building.price))
		niv_node.text = ("LV. " + str(building.niv))
		var texture = load(building.img_src) 
		if texture != null :
			img.texture = texture
	

func change_panel_container_color(new_color: Color) -> void:
	var stylebox = buyButtonPanel.get_theme_stylebox("panel")
	if stylebox == null:
		stylebox = StyleBoxFlat.new()
	stylebox.bg_color = new_color
	buyButtonPanel.add_theme_stylebox_override("panel", stylebox)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if building == null :
		return
		
	if building.is_bloqued() :
		buyButtonBloqued.visible = true
		buyButtonSell.visible = false
		change_panel_container_color(gray_color)
	else :
		if building.price > player_data.money:
			change_panel_container_color(gray_color)
		else : 
			change_panel_container_color(white_color)
		buyButtonBloqued.visible = false
		buyButtonSell.visible = true
			
		
