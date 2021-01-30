extends Area2D

export var id : int


func _ready() -> void:
	rotation_degrees = randi() % 360

func _on_LostObject_body_entered(body: Node) -> void:
	queue_free()
	body.pickObject(id)

func _physics_process(delta: float) -> void:
	rotation_degrees += delta*4
