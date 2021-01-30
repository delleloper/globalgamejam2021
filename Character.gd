extends PlanetFeature

export var requiredItem : int = 0
var missionStarted = false
var missionFinished = false
var item

func _ready() -> void:
	var item = ItemDb.getItem(requiredItem)

func getMission():
	if missionFinished:
		item = ItemDb.getRandomItem()

func onShipArrive(ship):
	getMission()
	if !missionStarted:
		print("i neeed item ", item.name)
		missionStarted = true
	else:
		if ship.inventory.has(requiredItem):
			print("Thank you")
			missionFinished = true
		else:
			print("please get me ", item.name)


func onShipStay(ship):
	print("goodbye")
