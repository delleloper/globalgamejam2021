extends Area2D

var direction = Vector2.ZERO
var bodies = []
var ship
var atraction = 2500
var distance

func _physics_process(delta: float) -> void:
	bodies = get_overlapping_bodies()
	if bodies:
		ship = bodies[0]
		direction =  global_position.direction_to(ship.global_position)
		distance = global_position.distance_to(ship.global_position)
		ship.velocity -=(direction * atraction * delta) / distance
