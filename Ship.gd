extends KinematicBody2D

onready var particles = $Particles2D
onready var cam = $Camera2D
onready var timer = $IdleTimer

onready var lostObjectScn = preload("res://LostObject.tscn")
export onready var shipStats = preload("res://Ships/BasicShip.tres")

var currentShip = 0
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var movementEnabled = true
var inventory = []
var zoomoout = false
var invertInput = true
var uiSlots = []

signal itemPicked

func _physics_process(delta: float) -> void:
	movement(delta)

func stopMoving():
	pass

func enterPlanet():
	pass

func exitPlanet():
	pass

func _input(event: InputEvent) -> void:
	getInputs()


func getInputs():
	if Input.is_action_just_pressed("ui_accept"):
		invertInput = !invertInput
	if !invertInput:
		direction.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
		direction.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	else:
		direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	if(direction.length() < 0.1):
		direction = Vector2.ZERO
	else:
		direction = direction.normalized()

func movement(delta):
	if direction.length() > 0.5:
		zoomoout = false
		shipStats.reduceFuel()
		particles.emitting = true
		cam.offset_h = lerp(cam.offset_h,direction.x, delta*2)
		cam.offset_v = lerp(cam.offset_v,direction.y, delta*2)
	else:
		if timer.is_stopped():
			timer.start()
		particles.emitting = false
	if velocity.length() > 0.001:
		look_at((global_position + velocity))


	if zoomoout:
		cam.zoom = lerp(cam.zoom, Vector2(2,2), delta/2)
	else:
		cam.zoom = lerp(cam.zoom, Vector2(4,4), delta/2)
	if shipStats.fuelAvaliable():
		velocity += direction * shipStats.speed * delta
		velocity = velocity.clamped(60)
	else:
		ranOutOfFuel()
	move_and_collide(velocity)
	velocity = velocity *0.99

func pickObject(object):
	if inventory.size() == 3:
		return
#		var lostObj = lostObjectScn.instance()
#		lostObj.id = removeItem(0)
#		lostObj.global_position = $drop.global_position
#		get_parent().add_child(lostObj)
	object.picked()
	var pickedItem = object.data
	var itemPos = inventory.size()
	print("picked",object.id)
	uiSlots.slots[itemPos].texture = pickedItem.image
	uiSlots.showItem(itemPos)
	inventory.append(object.id)
	emit_signal("itemPicked", object.data)



func removeItem(id):
	var itemInCargo = inventory.find(id)
	if itemInCargo != -1:
		inventory.remove(itemInCargo)
#		uiSlots.slots[itemInCargo].texture = null
		uiSlots.hideItem(itemInCargo)
	return id

func hasItem(id):
	return inventory.has(id)

func _on_Timer_timeout() -> void:
	zoomoout = true

func ranOutOfFuel():
	get_tree().change_scene("res://items/Gameover.tscn")
