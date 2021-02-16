extends PlanetFeature

var fuelAvaliable = 200
var rechargeAmount = 0.2

func onShipArrive(ship):
	animator.play("charge")
	print("entered recharge station")
	shipArrived = true

func onShipExit(ship):
	animator.play("idle")
	shipArrived = false
	ship.exitPlanet()
	print("fuel remaining: ",fuelAvaliable)

func onShipStay(ship):
	if fuelAvaliable && !ship.shipStats.tankFull():
		ship.shipStats.fuel += rechargeAmount
		fuelAvaliable -= rechargeAmount
	else:
		animator.play("idle")
