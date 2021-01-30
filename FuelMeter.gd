extends Control

var maxFuel = 100
var fuel = 100
var fullTexture = 208
onready var texture = $fill

var textureWidth = 208
export var playerPath : NodePath
var playerShip

func _ready():
	playerShip = get_node(playerPath)
	maxFuel = playerShip.maxFuel


func _process(delta: float) -> void:
	fuel = playerShip.fuel
	textureWidth = (fuel * fullTexture) /maxFuel
	texture.rect_size.x = textureWidth
