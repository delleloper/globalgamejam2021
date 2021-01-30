extends Area2D

var direction = Vector2.ZERO
var bodies = []
var ship
var atraction = 20

func _physics_process(delta: float) -> void:
	bodies = get_overlapping_bodies()
	if bodies:
		ship = bodies[0]
		direction =  global_position.direction_to(ship.global_position)
		ship.velocity += direction * atraction
