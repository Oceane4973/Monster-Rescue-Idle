extends PanelContainer

@export var name_node: Node
@export var description_node: Node
@export var benefice_node: Node
@export var price_node: Node
@export var ratio_nb_node: Node
@export var img: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func load_monster_class(monster : Monster):
	name_node.text = monster.name
	description_node.text = monster.description
	benefice_node.text = ('+' + str(monster.benefice))
	price_node.text = str(monster.price)
	ratio_nb_node.text = (str(monster.currentNB) + '/' + str(monster.maxNB))
	var texture = load(monster.img_src) 
	if texture != null :
		img.texture = texture
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
