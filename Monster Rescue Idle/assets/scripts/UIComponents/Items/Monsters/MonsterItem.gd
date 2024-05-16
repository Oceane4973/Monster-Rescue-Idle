extends PanelContainer

@export var monster_name : String
@export var description : String
@export var price : int
@export var benefice : int
@export var img_src : String
@export var currentNB : int
@export var maxNB : int

@onready var monster_name_label = $HBoxContainer/Description/Name
@onready var description_label = $HBoxContainer/Description/DescriptionLabel
@onready var benefice_label = $HBoxContainer/Description/HBoxContainer/Benefice/Benefice
@onready var price_label = $HBoxContainer/BuyButton/Price/Price
@onready var ratio_nb_monster = $HBoxContainer/Description/HBoxContainer/NbMax/NbRatio
@onready var img = $HBoxContainer/MonsterPreview/MonsterPreview


var monster = Monster.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	##A enlever c'est juste pour le test
	monster.name = monster_name
	monster.description = description
	monster.benefice = benefice
	monster.img_src = img_src
	monster.price = price
	monster.maxNB = maxNB
	monster.currentNB = currentNB
	
	#A deplacer plus tard pour changer la monster class
	monster_name_label.text = monster.name
	description_label.text = monster.description
	benefice_label.text = ('+' + str(monster.benefice))
	price_label.text = str(monster.price)
	ratio_nb_monster.text = (str(monster.currentNB) + '/' + str(monster.maxNB))
	
	var texture = load(img_src) 
	if texture != null :
		img.texture = texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
