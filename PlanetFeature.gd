extends Node2D
class_name PlanetFeature

var shipArrived = false
var ship = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func onShipArrive(ship):
	print("shipp enter")

func onShipExit(ship):
	print("ship exit")

func onShipStay(ship):
	print("ship stay")

func _process(delta: float) -> void:
	if shipArrived:
		onShipStay(ship)

func _on_Detector_body_entered(body: Node) -> void:
		ship = body
		ship.enterPlanet()
		onShipArrive(body)


func _on_Detector_body_exited(body: Node) -> void:
	onShipExit(body)
	var shipArrived = false
	var ship = null
