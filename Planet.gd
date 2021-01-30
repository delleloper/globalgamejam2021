extends StaticBody2D


onready var aura1 = $aura1
onready var aura2 = $aura2

func _process(delta: float) -> void:
	aura1.rotation_degrees += delta * 2
	aura2.rotation_degrees += -delta * 2
