extends Area2D

export var id : int
export var data :Resource


func _ready() -> void:
	if !data:
		data = ItemDb.getRandomItem()
	rotation_degrees = randi() % 360
	$icon.texture = data.image

func _on_LostObject_body_entered(body: Node) -> void:
	body.pickObject(self)

func picked():
	$AnimationPlayer.play("pick")

func _physics_process(delta: float) -> void:
	rotation_degrees += delta*4
