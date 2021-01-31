extends Node2D
class_name PlanetFeature

var shipArrived = false
var ship = null
onready var animator = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func onShipArrive(ship):
	print("ship enter")

func onShipExit(ship):
	print("ship exit")

func onShipStay(ship):
	print("ship stay")

func _process(delta: float) -> void:
	if shipArrived:
		onShipStay(ship)

func _on_Detector_body_entered(body: Node) -> void:
	ship = body
	shipArrived = true
	ship.enterPlanet()

	onShipArrive(body)


func _on_Detector_body_exited(body: Node) -> void:
	onShipExit(body)
	shipArrived = false
	ship = null
