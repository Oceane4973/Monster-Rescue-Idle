extends RefCounted
class_name Monster

# Déclaration des variables membres
var name : String
var description : String
var price : int
var img_src : String
var currentNB : int
var benefice : int
var maxNB : int
var model_src : String

# Constructeur
func _init(name: String = "", description: String = "", price: int = 0, img_src: String = "", currentNB: int = 0, benefice: int = 0, maxNB: int = 0, model_src: String = ""):
	self.name = name
	self.description = description
	self.price = price
	self.img_src = img_src
	self.model_src = model_src
	self.currentNB = currentNB
	self.benefice = benefice
	self.maxNB = maxNB

# Méthode pour convertir en dictionnaire
func to_dict() -> Dictionary:
	return {
		"name": name,
		"description": description,
		"price": price,
		"img_src": img_src,
		"currentNB": currentNB,
		"benefice": benefice,
		"maxNB": maxNB,
		"model_src" : model_src
	}

# Méthode pour créer un objet à partir d'un dictionnaire
static func from_dict(dict: Dictionary) -> Monster:
	return Monster.new(dict.get("name", ""), dict.get("description", ""), dict.get("price", 0), dict.get("img_src", ""), dict.get("currentNB", 0), dict.get("benefice", 0), dict.get("maxNB", 0), dict.get("model_src", ""))

# Méthode pour convertir une liste de Monster en JSON
static func list_to_json(monsters: Array) -> String:
	var json_array = []
	for monster in monsters:
		json_array.append(monster.to_dict())
	return JSON.stringify(json_array)

# Méthode pour créer une liste de Monster à partir d'un JSON
static func list_from_json(json_str: String) -> Array:
	var result = JSON.parse_string(json_str)
	var json_array = result
	var monsters = []
	for json_monster in json_array:
		monsters.append(Monster.from_dict(json_monster))
	return monsters

func is_bloqued() -> bool:
	return false
	
