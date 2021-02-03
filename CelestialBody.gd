extends Node2D

export var radius : float
export var surfaceGravity : float
var mass : float
export var initialVelocity : Vector2
var currentVelocity : Vector2
const gravitationalConstant = 1
var maxerror = 0.25
export var color : Color

func _draw():
	if radius <= 0.0:
		return
	var maxpoints = 1024 # I think this is renderer limit
	var numpoints = ceil(PI / acos(1.0 - maxerror / radius))
	numpoints = clamp(numpoints, 3, maxpoints)
	var points = PoolVector2Array([])
	for i in numpoints:
		var phi = i * PI * 2.0 / numpoints
		var v = Vector2(sin(phi), cos(phi))
		points.push_back(v * radius)
	draw_colored_polygon(points, color)

func _ready() -> void:
	currentVelocity = initialVelocity
	mass = surfaceGravity * radius * radius / Universe.gravitationalConstant

func updateVelocity(allBodies: Array, timeStep: float):
	for otherBody  in allBodies:
		if otherBody != self:
			var sqrDist = sqrt(global_position.distance_to(otherBody.global_position))
			var forceDir : Vector2 = (otherBody.global_position -global_position).normalized()
			var acceleration : Vector2 = forceDir * Universe.gravitationalConstant * otherBody.mass / sqrDist
			currentVelocity += acceleration * timeStep

func  updatePosition(timeStep:float):
	position += currentVelocity * timeStep
