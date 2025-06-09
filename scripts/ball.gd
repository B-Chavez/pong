extends RigidBody2D

@export var speed : float = 400.0 #Speed of ball, can change in inspector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#random initial direction
	var angle = randf() * PI * 2
	linear_velocity = Vector2.RIGHT.rotated(angle) * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
