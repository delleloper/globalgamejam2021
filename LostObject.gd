extends Area2D

export var id : int

func _on_LostObject_body_entered(body: Node) -> void:
	queue_free()
	body.pickObject(id)
