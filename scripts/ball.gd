extends RigidBody2D

@export var speed : float = 400.0 #Speed of ball, can change in inspector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#random initial direction
	var angle = randf() * TAU #randf() returns a float 0.0 to 1.0, then you multiply it by TAU(PI * 2) which gives you 360 degrees by it self
	#Because PI is 180 degrees
	linear_velocity = Vector2.RIGHT.rotated(angle) * speed 
	#Vector2.RIGHT Face your character right, then rotate in a random 360 deg
	#then move your ball at that speed

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# ensure we keep exactly 'speed' magitude
	var lv = state.get_linear_velocity()
	if lv != Vector2.ZERO:
		state.set_linear_velocity(lv.normalized() * speed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
