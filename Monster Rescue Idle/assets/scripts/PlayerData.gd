extends Node

@export var money: int = 0

@export var prestance: int = 0;

func _ready():
	money = 0;
	prestance = 0;

func _process(delta):
	pass
	money += 1
	prestance += 1

func save():
	var value = {
		"money": money,
		"prestance": prestance
	}
	return value;
