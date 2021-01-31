extends KinematicBody2D

onready var particles = $Particles2D
onready var cam = $Camera2D

export var moveSpeed = 2
export var fuelConsumtion= 0.02
export var maxFuel = 100

var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var fuel : float = maxFuel
var movementEnabled = true
var inventory = []

var invertInput = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		invertInput = !invertInput
	if !invertInput:
		getInputs()
	else:
		getInputsInverted()
	movement(delta)

func stopMoving():
	pass

func enterPlanet():
	pass

func exitPlanet():
	pass

func getInputs():
	direction.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	direction.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	if(direction.length() < 0.1):
		direction = Vector2.ZERO
	else:
		direction = direction.normalized()

func getInputsInverted():
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	if(direction.length() < 0.1):
		direction = Vector2.ZERO
	else:
		direction = direction.normalized()



func movement(delta):
	if direction.length() > 0.5:
		fuel-= fuelConsumtion
		particles.emitting = true
	else:
		particles.emitting = false
	if velocity.length() > 0.001:
		look_at((global_position + velocity))
	fuel = clamp(fuel,0,100)


	if fuel:
		velocity += direction*moveSpeed*delta
		velocity = velocity.clamped(60)
	if !fuel:
		print("no more fuel")
	move_and_collide(velocity)
	velocity = velocity *0.99

func pickObject(id):
	print("picked",id)
	inventory.append(id)
