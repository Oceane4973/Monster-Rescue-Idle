extends Node

@export var money: int = 0
@export var prestance: int = 0;
var list_Of_Monsters = [
	Monster.new("slime", "A slimy creature", 500, "res://assets/textures/avatar.png", 5, 2, 10),
	Monster.new("slime", "A slimy creature", 10, "res://assets/textures/avatar.png", 5, 2, 10)
] :
	set (value):
		var monsters = Monster.list_from_json(value)
		list_Of_Monsters = monsters;

func _ready():
	money = 0;
	prestance = 0;

func _process(delta):
	money += 1
	prestance += 1

func save():
	var value = {
		"money": money,
		"prestance": prestance,
		"list_Of_Monsters" : Monster.list_to_json(list_Of_Monsters)
	}
	return value;
