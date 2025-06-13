extends CanvasLayer
class_name floating_debug_info

@export var parentNode: Node
@onready var labelNode = $Label

var constantUpdatedPos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_updateInfo() #Since this is in _process call this function every frame
	pass

#Get parent node name then move to the next line and show Position: after
#changing parent node position to a string
func _updateInfo():
	labelNode.text = str(parentNode.name) + " \nPosition: " + str(parentNode.position) + "\nContacts: " + str(parentNode.get_contact_count())
	
	pass
