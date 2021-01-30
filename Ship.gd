extends KinematicBody2D


export var moveSpeed = 2
var direction = Vector2.ZERO
var vector
var velocity = Vector2.ZERO
var maxFuel = 100
export var fuel : float = maxFuel
export var fuelConsumtion= 0.02
var movementEnabled = true
var inventory = []

func _physics_process(delta: float) -> void:
	getInputs()
	movement(delta)
func stopMoving():
	pass

func enterPlanet():
	pass

func exitPlanet():
	pass

func getInputs():
	direction.x += Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	direction.y += Input.get_action_strength("move_up") - Input.get_action_strength("move_down")

func movement(delta):
	if direction.length() > 2:
		fuel-= fuelConsumtion
		direction = direction.linear_interpolate(Vector2.ZERO,delta)
	fuel = clamp(fuel,0,100)
	look_at(direction)
	if fuel:
		velocity = direction*moveSpeed*delta
	if !fuel:
		print("no more fuel")
	velocity = velocity.linear_interpolate(Vector2.ZERO,delta)
	move_and_collide(velocity)

func pickObject(id):
	print("picked",id)
	inventory.append(id)
