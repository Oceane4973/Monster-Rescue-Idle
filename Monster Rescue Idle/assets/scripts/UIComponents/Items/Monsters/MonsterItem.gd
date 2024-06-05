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
var player_data = null

func _ready():
	player_data = get_node("/root/PlayerData")
	
func is_bloqued() -> bool:
	return true
	
	
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
	var stylebox = buyButtonPanel.get_theme_stylebox("panel")
	if stylebox == null:
		stylebox = StyleBoxFlat.new()
	stylebox.bg_color = new_color
	buyButtonPanel.add_theme_stylebox_override("panel", stylebox)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_bloqued() :
		buyButtonBloqued.visible = true
		buyButtonSell.visible = false
		change_panel_container_color(gray_color)
	else :
		if monster.price > player_data.money:
			change_panel_container_color(gray_color)
		else : 
			change_panel_container_color(white_color)
		buyButtonBloqued.visible = false
		buyButtonSell.visible = true
			
		
