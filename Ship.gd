extends KinematicBody2D


export var moveSpeed = 2
var direction = Vector2.ZERO
var vector
var velocity = Vector2.ZERO
var maxFuel = 9999
export var fuel : float = maxFuel
export var fuelConsumtion= 0.2
var movementEnabled = true
var inventory = []

func _physics_process(delta: float) -> void:
	getInputs()
	movement(delta)
func stopMoving():
	movementEnabled = false

func enterPlanet():
	direction = Vector2.ZERO
	velocity = Vector2.ZERO

func exitPlanet():
	movementEnabled = true

func getInputs():
	direction.x += Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	direction.y += Input.get_action_strength("move_up") - Input.get_action_strength("move_down")

func movement(delta):
	if direction.length() > 2:
		fuel-= fuelConsumtion
		direction = direction.linear_interpolate(Vector2.ZERO,delta)
	fuel = clamp(fuel,0,100)
	look_at(direction)
	if movementEnabled && fuel:
		velocity = direction*moveSpeed*delta
	if !fuel:
		print("no more fuel")
	velocity = velocity.linear_interpolate(Vector2.ZERO,delta)
	move_and_collide(velocity)

func pickObject(id):
	print("picked",id)
	inventory.append(id)
