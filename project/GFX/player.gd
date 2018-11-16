extends KinematicBody2D

const SPEED = 6
const MAX_SPEED = 3

var velocity = Vector2()
var acceleration = Vector2()

var RayUp = RayCast2D
var RayDown = RayCast2D
var RayLeft = RayCast2D
var RayRight = RayCast2D

func _ready():
	RayUp = $RayUp
	RayDown = $RayDown
	RayLeft = $RayLeft
	RayRight = $RayRight

func _physics_process(delta):

	# x input
	if(Input.is_action_pressed("left")):
		acceleration.x = -1
	elif(Input.is_action_pressed("right")):
		acceleration.x = 1
	else:
		acceleration.x = 0
		velocity.x *= 0.85

	# y input
	if(Input.is_action_pressed("up")):
		acceleration.y = -1
	elif(Input.is_action_pressed("down")):
		acceleration.y = 1
	else:
		acceleration.y = 0
		velocity.y *= 0.85

	# adding and clamping velocity
	velocity += acceleration * SPEED * delta
	velocity = velocity.clamped(MAX_SPEED)

	# collision checking
	if(RayUp.is_colliding() && velocity.y < 0):
		velocity.y = 0
	if(RayDown.is_colliding() && velocity.y > 0):
		velocity.y = 0
	if(RayLeft.is_colliding() && velocity.x < 0):
		velocity.x = 0
	if(RayRight.is_colliding() && velocity.x > 0):
		velocity.x = 0


	# make the move
	position += velocity