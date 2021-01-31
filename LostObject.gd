extends Area2D

export var id : int
var data

func _ready() -> void:
	rotation_degrees = randi() % 360
	data = ItemDb.getItem(id)

func _on_LostObject_body_entered(body: Node) -> void:
	body.pickObject(self)

func picked():
	$AnimationPlayer.play("pick")

func _physics_process(delta: float) -> void:
	rotation_degrees += delta*4
