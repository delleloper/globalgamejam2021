extends Control

export var item : Resource
export var timeDuration : float

onready var texture :TextureRect = $HSplitContainer/CenterContainer/texture
onready var itemName : Label = $HSplitContainer/MarginContainer/VSplitContainer/name
onready var itemDescription : RichTextLabel = $HSplitContainer/MarginContainer/VSplitContainer/description
onready var animator = $AnimationPlayer
onready var timer = $Timer

func _ready() -> void:
	setResource()
	if timeDuration > 0: timer.start(timeDuration)

func setResource():
	if !item: return
	itemName.text = item.name
	itemDescription.text = item.description
	print(item.image)
	texture.texture = item.image
	print(texture.texture)

func _on_Timer_timeout() -> void:
	animator.play("exit")

#func _process(delta: float) -> void:
#	if Input.is_action_just_pressed("action"):
#		animator.play("exit")
