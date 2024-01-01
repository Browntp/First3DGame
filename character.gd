extends CharacterBody3D

var bullet_scene = preload("res://bullet.tscn")

const SPEED = 20
const JUMP_VELOCITY = 15
var CameraRotation = Vector2(0,0)
var MouseSensisitivy = 0.002

@onready var head = $Head
@onready var MainCamera = $Head/Camera3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 20



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseMotion:
		var MouseEvent = event.relative *MouseSensisitivy
		
		CameraLook(MouseEvent)
		
func CameraLook(Movement: Vector2):
	CameraRotation += Movement
	CameraRotation.y = clamp(CameraRotation.y,-1.5,1.2)
	
	transform.basis = Basis()
	MainCamera.transform.basis = Basis()
	
	rotate_object_local(Vector3(0,1,0), -CameraRotation.x) # first rotate y
	MainCamera.rotate_object_local(Vector3(1,0,0), -CameraRotation.y) #then rotate x


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var camera_transform = MainCamera.global_transform
	var direction = Vector3.ZERO
	if input_dir:
		direction = (camera_transform.basis.x * input_dir.x + camera_transform.basis.z * input_dir.y).normalized()
		
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	move_and_slide()





