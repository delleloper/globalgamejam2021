extends Node2D

var bodies : Array

func _ready() -> void:
	bodies = get_children()

func _physics_process(delta: float) -> void:
	for body in bodies:
		body.updateVelocity(bodies,Universe.physicsTimeStep)

	for body in bodies:
		body.updatePosition(Universe.physicsTimeStep)
