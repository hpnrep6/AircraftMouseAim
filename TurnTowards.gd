extends RigidBody

var mouseX;
var mouseY;

onready var target = $TargetPivot/Target;
onready var pivot = $TargetPivot;
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);

func _input(event):
	if event is InputEventMouseMotion:
		mouseX = event.relative.x;
		mouseY = event.relative.y;
		#pivot.rotate_y(-mouseX / 1000);
		#pivot.rotate_x(-mouseY / 1000);
		target.transform.origin = target.transform.origin.rotated(pivot.transform.basis.y, -mouseX * 0.001)
		target.transform.origin = target.transform.origin.rotated(pivot.transform.basis.x, -mouseY * 0.001)
		#print(pivot.global_transform.basis.x)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	keyboardMove(delta);
	
	turnTowards();
	
	# Dampen angular and linear velocity
	add_torque(-angular_velocity * 50);
	
	add_central_force(-linear_velocity);

	#pivot.rotate_x(-pivot.rotation.x * .05);
	#pivot.rotate_y(-pivot.rotation.y * .05);
	mouseX = 0;
	mouseY = 0;

# Rotate towards the point
func turnTowards():
	# Convert target's location to local world position
	var local = to_local(target.global_transform.origin);
	#var local = pivot.rotation * 20
	local = target.transform.origin;
	# Add torque towards the target. This torque should *probably* be the ideal torque, so
	# some counter torque needs to be added if no dampening is added
	#add_torque(local)
	print(local)
	#add_torque(Vector3(local.y, -local.x, 0) * global_transform.basis.y * 5)
	add_torque((local.y * global_transform.basis.x + -local.x * global_transform.basis.y) * 5)
	
func keyboardMove(delta):
	if(Input.is_key_pressed(KEY_E)):
		#add_torque(global_transform.basis.y * -1 * 20);
		target.transform = target.transform.translated(Vector3(delta, 0, 0))
	if(Input.is_key_pressed(KEY_Q)):
		target.transform = target.transform.translated(Vector3(-delta, 0, 0))
		#add_torque(global_transform.basis.y * 1 * 20);
		
	if(Input.is_key_pressed(KEY_W)):
		target.transform = target.transform.translated(Vector3(0, delta, 0))
		#add_torque(global_transform.basis.x * -1 * 20);
	if(Input.is_key_pressed(KEY_S)):
		target.transform = target.transform.translated(Vector3(0, -delta, 0))
		#add_torque(global_transform.basis.x * 1 * 20);
		
	if(Input.is_key_pressed(KEY_D)):
		add_torque(global_transform.basis.z * -1 * 20);
	if(Input.is_key_pressed(KEY_A)):
		add_torque(global_transform.basis.z * 1 * 20);
	
	if(Input.is_key_pressed(KEY_SPACE)):
		add_central_force(-global_transform.basis.z * 15);
