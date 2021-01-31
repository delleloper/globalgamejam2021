extends PlanetFeature

export var requiredItem : int = 0
var missionStarted = false
var missionFinished = false
var item

func getMission():
	if missionFinished:
		item = ItemDb.getRandomItem()
	else:
		item = ItemDb.getItem(requiredItem)

func onShipArrive(ship):
	getMission()
	print(animator.current_animation)
	animator.play("showBubble")
	if !missionStarted:
		print("i neeed item ", item.name)
		missionStarted = true
	else:
		if ship.inventory.has(requiredItem):
			print("Thank you")
			missionStarted = false
			missionFinished = true
		else:
			print("please get me ", item.name)

func onShipExit(ship):
	print("goodbye")
	animator.play_backwards("showBubble")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "showBubble" && shipArrived:
		animator.play("bubbleIddle")
