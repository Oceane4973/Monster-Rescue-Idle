extends RefCounted
class_name Building

# Déclaration des variables membres
var name : String
var description : String
var price : int
var img_src : String
var niv : int
var benefice : int

# Constructeur
func _init(name: String = "", description: String = "", price: int = 0, img_src: String = "", niv: int = 0, benefice: int = 0):
	self.name = name
	self.description = description
	self.price = price
	self.img_src = img_src
	self.niv = niv
	self.benefice = benefice

# Méthode pour convertir en dictionnaire
func to_dict() -> Dictionary:
	return {
		"name": name,
		"description": description,
		"price": price,
		"img_src": img_src,
		"niv": niv,
		"benefice": benefice
	}

# Méthode pour créer un objet à partir d'un dictionnaire
static func from_dict(dict: Dictionary) -> Building:
	return Building.new(dict.get("name", ""), dict.get("description", ""), dict.get("price", 0), dict.get("img_src", ""), dict.get("niv", 0), dict.get("benefice", 0))

# Méthode pour convertir une liste de Monster en JSON
static func list_to_json(buildings: Array) -> String:
	var json_array = []
	for building in buildings:
		json_array.append(building.to_dict())
	return JSON.stringify(json_array)

# Méthode pour créer une liste de Monster à partir d'un JSON
static func list_from_json(json_str: String) -> Array:
	var result = JSON.parse_string(json_str)
	var json_array = result
	var buildings = []
	for json_building in json_array:
		buildings.append(Building.from_dict(json_building))
	return buildings

func is_bloqued() -> bool:
	return false
