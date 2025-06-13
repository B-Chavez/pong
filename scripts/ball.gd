extends RigidBody2D

@export var speed : float = 400.0 #Speed of ball, can change in inspector
var _impact_recorded: bool



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 4
	#Serve the ball
	#random initial direction
	var angle = randf() * TAU #randf() returns a float 0.0 to 1.0, then you multiply it by TAU(PI * 2) which gives you 360 degrees by it self
	#Because PI is 180 degrees
	linear_velocity = Vector2.RIGHT.rotated(angle) * speed 
	#Vector2.RIGHT Face your character right, then rotate in a random 360 deg
	#then move your ball at that speed

#WHenever the physics engine steps forward it gives each RigidBody2D a chance to inspect
#and tweak it's own simulation state. By default this func is called before Godot applies
#gravity, forces, and collisions for that frame, so whatever you do here will be included in the
#upcoming physics solve



func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# ensure we keep exactly 'speed' magitude
	# the type of "state" is PhysicsDirectBodyState2D
	# gives you direct access to the body's physics internals for this exact frame:
	# velocity, forces, transform, mass, etc.
	var lv = state.get_linear_velocity() #reads the body's current velocity vector (in pixels/sec)
	var dir: Vector2
	if lv.length() > 0.001: #ensures speed is constant
		dir = lv.normalized()
		#Overwrites the body's current velocity vector for the next physics solve
		state.set_linear_velocity(dir * speed)
		
	var cnt = state.get_contact_count()
	for i in range(cnt):
		var collider = state.get_contact_collider_object(i)
		#If player paddle is hit
		if collider is RigidBody2D:
			#grab collision normal at contact
			var normal = state.get_contact_local_normal(i)
			#reflect lv and re-scale
			lv = lv.bounce(normal).normalized() * speed
	
	_captureFirstContact(state)
			
	state.set_linear_velocity(lv)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _captureFirstContact(stateagain: PhysicsDirectBodyState2D):
	if stateagain.get_contact_count() > 0 :
		_impact_recorded = true
		# 0 = first contact
		var world_pos = stateagain.get_contact_collider_position(0)
		print("Impact X: ", world_pos.x)


func _on_body_entered(body: Node) -> void:
	pass # Replace with function body.
