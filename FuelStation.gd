extends PlanetFeature

var fuelAvaliable = 200
var rechargeAmount = 0.5

func onShipArrive(ship):
	print("entered recharge station")
	shipArrived = true

func onShipExit(ship):
	shipArrived = false
	ship.exitPlanet()
	print("fuel remaining: ",fuelAvaliable)

func onShipStay(ship):
	if fuelAvaliable && ship.fuel < ship.maxFuel:
		ship.fuel += rechargeAmount
		fuelAvaliable -= rechargeAmount
