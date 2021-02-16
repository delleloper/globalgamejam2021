extends Node

export var objects =  []
var size

func _ready() -> void:
	size = objects.size()

func getItem(id):
	return objects[id]

func getRandomItem():
	var random = randi() % size
	return getItem(random)
