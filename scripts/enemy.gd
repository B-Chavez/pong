extends Node2D

@export var speed: float = 300.0
@export var ball_path: NodePath
@export var top_limit: float = 0.0
@export var bottom_limit: float = 720.0 #Set to viewport height minus half the paddle height
@export var move_threshold: float = 5.0 #don't twitch for tiny diffs

@onready var ball := get_node(ball_path) as RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var bv = ball.linear_velocity
	
	#If balls velocity is either stationary or moving to the left (away from enemy)
	#then stop moving enemy paddle by returning and ending the _physics_process
	if bv.x <= 0:
		return
	
	#Uses _predict_ball() to compute the final y coordinate of the ball when it crosses the
	#paddle's X-line, accounting for any number of top/bottom bounces
	var target_y = _predict_ball_y()
	
	var diff = target_y - position.y #Take the calculated position the ball will be in and 
	#subtract position.y (the paddel's position in the world on the y axis) to get the
	#position the paddle should be in
	
	#if the diff is negative turn it into a positive and if that's more than the
	#move_threshold then 
	if abs(diff) > move_threshold: 
		#assign Enemy node's position to
		#sign(diff) if diff is 1 or more then return 1, if diff is 0 return 0,
		#if diff is -1 or lower return -1. This is all to determine if you'll move
		#up, down, or stationary. 1 down, -1 up, 0 don't move
		#then multiply that return value by your speed and then by delta
		#this is all to determine how far you'll move this frame at full speed
		position.y += sign(diff) * speed * delta
		#example: 1 * 300 * 0.016 = positive 4.8px
	
	#Clamp so we never go off-screen by forcing the position.y to be within
	#top_limit = 0 (this is 0 because the top of the viewport is at y = 0)
	#and bottom_limit = 720
	position.y = clampf(position.y, top_limit, bottom_limit)
	
func _predict_ball_y() -> float:
	var bp = ball.position
	var bv = ball.linear_velocity
	var height = bottom_limit - top_limit
	
		
	#time for the ball to reach this paddle's X
	var t = (position.x - bp.x) / bv.x
	
	#Simple projection (ignoring walls)
	var proj_y = bp.y + bv.y * t
	
	#"Fold" that proj_y into [0 .. 2*height), then mirror the second half 
	var y = fposmod(proj_y - top_limit, height * 2)
	if y > height:
		y = (height * 2) - y
		
	return	 y + top_limit
