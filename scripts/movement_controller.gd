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
	if _velocity != Vector2.ZERO: #if the velocity is not 0,0 then
		#get the parent node's velocity and assign it the velocity made in set_direction()
		get_parent().velocity = _velocity
	else: #else set the velocity of the parent node to stop 0,0
		get_parent().velocity = Vector2.ZERO
	
	#move and slide handles moving and scales it by delta and also lets you slide along any colliding surface
	get_parent().move_and_slide()
