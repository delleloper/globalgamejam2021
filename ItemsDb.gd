extends Node

export var objects =  []
var size

func _ready() -> void:
	size = objects.size()

func getItem(id):
	return objects[0]

func getRandomItem():
	var random = randi() % size + 1
	return getItem(random)
