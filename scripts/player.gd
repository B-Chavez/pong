extends Node2D
class_name player

@onready var input_handler = $InputHandler
@onready var movement_ctrl = $MovementController

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Does this, movement_ctrl.set_direction(new_dir)
	input_handler.direction_changed.connect(movement_ctrl.set_direction)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
