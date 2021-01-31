extends TextureRect

var slots
export var shipPath : NodePath
var ship
onready var curveTween  = $CurveTween
var currentSlot

func _ready():
	slots = get_children()
	slots.remove(0)
	var ship = get_node(shipPath)
	ship.uiSlots = self

func showItem(id):
	currentSlot = slots[id]
	curveTween.play(0.5, 0, 0.3)

func hideItem(id):
	currentSlot = slots[id]
	curveTween.play(0.5, 0.3, 0)

func _on_CurveTween_curve_tween(sat):
	currentSlot.scale.x  = sat
	currentSlot.scale.y  = sat
