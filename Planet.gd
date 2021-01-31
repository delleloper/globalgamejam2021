extends StaticBody2D

onready var aura1 = $aura1
onready var aura2 = $aura2
onready var atmosphere = $Atmosphere

var direction = Vector2.ZERO
var bodies = []
var ship
export var atraction = 2500
var distance

func _process(delta: float) -> void:
	aura1.rotation_degrees += delta * 4
	aura2.rotation_degrees += -delta * 4

func _physics_process(delta: float) -> void:
	bodies = atmosphere.get_overlapping_bodies()
	if bodies:
		ship = bodies[0]
		direction = global_position.direction_to(ship.global_position)
		distance = global_position.distance_to(ship.global_position)
		ship.velocity -= (direction * atraction * delta) / distance
