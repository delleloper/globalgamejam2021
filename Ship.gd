extends KinematicBody2D

onready var particles = $Particles2D
onready var cam = $Camera2D
onready var timer = $IdleTimer


export var moveSpeed = 2
export var fuelConsumtion= 0.02
export var maxFuel = 100

var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var fuel : float = maxFuel
var movementEnabled = true
var inventory = []
var zoomoout = false
var invertInput = true
var uiSlots = []

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
		zoomoout = false
		fuel-= fuelConsumtion
		particles.emitting = true
		cam.offset_h = lerp(cam.offset_h,direction.x, delta*2)
		cam.offset_v = lerp(cam.offset_v,direction.y, delta*2)
	else:
		if timer.is_stopped():
			timer.start()
		particles.emitting = false
	if velocity.length() > 0.001:
		look_at((global_position + velocity))
	fuel = clamp(fuel,0,100)

	if zoomoout:
		cam.zoom = lerp(cam.zoom, Vector2(2,2), delta/2)
	else:
		cam.zoom = lerp(cam.zoom, Vector2(3,3), delta/2)
	if fuel:
		velocity += direction*moveSpeed*delta
		velocity = velocity.clamped(60)
	if !fuel:
		print("no more fuel")
	move_and_collide(velocity)
	velocity = velocity *0.99

func pickObject(object):
	print(inventory.size())
	if inventory.size() < 3:
		object.picked()
		var pickedItem = ItemDb.getItem(object.id)
		var itemPos = inventory.size() - 1
		print("picked",object.id)
		inventory.append(itemPos)
		uiSlots.slots[itemPos].texture = pickedItem.image
		uiSlots.showItem(itemPos)

func removeItem(id):
	var itemInCargo = inventory.find(id)
	if itemInCargo != -1:
		inventory.remove(itemInCargo)
#		uiSlots.slots[itemInCargo].texture = null
		uiSlots.hideItem(id)

func hasItem(id):
	return inventory.has(id)

func _on_Timer_timeout() -> void:
	zoomoout = true
