extends Control


export var playerPath : NodePath

var playerShip
onready var label = $RichTextLabel

func _ready():
	playerShip = get_node(playerPath)

func _process(delta: float) -> void:
	label.text = str(playerShip.fuel)
