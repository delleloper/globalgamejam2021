extends Resource

class_name shipStats

export var fuelTankSize : int
export var fuelConsumption : float
export var speed : float
export var fuel : float

func fuelRemaining():
	return fuel

func tankFull():
	print(str(fuel)+" - " + str(fuelTankSize))
	return fuel >= fuelTankSize

func fuelAvaliable():
	return fuel > 0

func setFuel(val):
	fuel = clamp(val,0,fuelTankSize)
	if fuel >= fuelTankSize:
		emit_signal("tankFull")

func reduceFuel():
	fuel-= fuelConsumption

func refillFuel(val):
	fuel += val
