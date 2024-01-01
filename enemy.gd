extends CharacterBody3D

var id 

const X_SPEED = 10
const Z_SPEED = 10
const JUMP_VELOCITY = 4.5
var health = 100
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity  = 9.81
var direction = Vector3.ZERO
var x = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta 

	velocity.x = direction.x * delta * X_SPEED 
	velocity.z = direction.z * delta * Z_SPEED + sin(x)*5
	direction.y = 0
	x += 0.05
	
	
	look_at(direction.normalized(),Vector3(0,1,0))
	
	move_and_slide()
