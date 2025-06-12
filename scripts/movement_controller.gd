extends Node2D

#Make the variable speed changable in the inspector
#Also set the default speed to 200
@export var speed := 200

#Set _velocity to nothing 0,0
var _velocity := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#set the direction and speed we'll be moving in then assign that to _velocity
func set_direction(dir: Vector2):
	_velocity = dir * speed

func _physics_process(delta: float) -> void:
	var body = get_parent() as RigidBody2D
	#RigidBody2D uses .linear_velocity, not .velocity
	body.linear_velocity = _velocity
