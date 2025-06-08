extends Node
signal	direction_changed(new_dir: Vector2) #Declare the signal carrying the raw input vector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	#Move only on the y axis because Vector2 takes 2 float arguments I've set the x to 0 and let the
	# y axis be controlled by the Inputs
	var dir := Vector2(
		0, 
		# get_action_stength() receives a value from 0 to 1 for each press, these are mainly for analog and triggers
		Input.get_action_strength("moveUp") - Input.get_action_strength("moveDown")
	)
	if dir != Vector2.ZERO: #if dir is not set at 0,0 then run below
		dir = dir.normalized() #Keeps diagonal inputs from being faster than up,down,left,right inputs
	
	#emit signal "direction_changed" and pass dir	
	emit_signal("direction_changed", dir) 
