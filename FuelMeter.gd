extends Control

var maxFuel = 100
var fuel = 100
var fullTexture = 208
onready var texture = $fill
onready var arrow = $fuel_arrow
var textureWidth = 208
export var playerPath : NodePath
var playerShip

func _ready():
	playerShip = get_node(playerPath)
	maxFuel = playerShip.maxFuel


func _process(delta: float) -> void:
	fuel = playerShip.fuel
	texture.rect_rotation = lerp(-180, 0, fuel/maxFuel)
	arrow.rect_rotation = lerp(-105, 105, fuel/maxFuel)

