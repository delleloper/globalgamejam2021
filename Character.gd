extends PlanetFeature

export var requiredItem : int = 0
var missionStarted = false
var missionFinished = false
var item
onready var audioPlayer = $AudioStreamPlayer
onready var missionCompleteAudio = $missionComplete

onready var object = $planet_round_bubble/object

func _ready() -> void:
	getMission()

func getMission():
	if missionFinished:
		item = ItemDb.getRandomItem()
		requiredItem = item.id
	else:
		item = ItemDb.getItem(requiredItem)

func onShipArrive(ship):
	object.texture = item.image
	audioPlayer.play()
	print(animator.current_animation)
	animator.play("showBubble")
	if !missionStarted:
		print("i neeed item ", item.name)
		missionStarted = true
	else:
		print(ship.hasItem(requiredItem))
		if ship.hasItem(requiredItem):
			ship.removeItem(requiredItem)
			object.texture = preload("res://Assets/Props/emoji-smile.png")
			missionCompleteAudio.play()
			print("Thank you")
			missionStarted = false
			missionFinished = true
			getMission()
		else:
			print("please get me ", item.name)

func onShipExit(ship):
	print("goodbye")
	animator.play_backwards("showBubble")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "showBubble" && shipArrived:
		animator.play("bubbleIddle")
