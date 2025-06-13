extends Node2D

@export var speed: float = 300.0
@export var ball_path: NodePath
@export var top_limit: float = 0.0
@export var bottom_limit: float = 720.0 #Set to viewport height minus half the paddle height

@onready var ball := get_node(ball_path) as RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var target_y = _predict_ball_y()
	var diff = target_y - position.y
	if abs(diff) > 5:
		position.y += sign(diff) * speed * delta
		position.y = clamp(position.y, top_limit, bottom_limit)
		
func _predict_ball_y() -> float:
	var bp = ball.position
	var bv = ball.linear_velocity
	#if the ball is moving away or not at all, just hover mid-screen
	if bv.x == 0 or (position.x - bp.x) / bv.x <= 0:
		return (top_limit + bottom_limit) * 0.5
		
	#time for the ball to reach this paddle's X
	var t = (position.x - bp.x) / bv.x
	var proj_y = bp.y + bv.y * t
	
	#reflect off top/bottom between [top_limit, bottom_limit]
	var limitedrange = (bottom_limit - top_limit)
	#map proj_y into repeated (0..2*range) domain
	var y = fposmod(proj_y - top_limit, limitedrange * 2)
	#if it's in the "bounce" half, flip it back down
	if y > range:
		y = limitedrange * 2 - y
	return	 y + top_limit
