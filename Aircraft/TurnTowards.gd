extends RigidBody

var pitch : float = 4;
var roll : float = 2;
var yaw : float = 0.8;

onready var target = $TargetPivot/Target;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	keyboardMove(delta);
	
	turnTowards();
	
	# Dampen angular and linear velocity
	add_torque(-angular_velocity * 50);
	
	add_central_force(-linear_velocity);

# Rotate towards the point
func turnTowards():
	# Convert target's location to local world position
	var local = to_local(target.global_transform.origin);

	# Add torque towards the target. This torque should *probably* be the ideal torque, so
	# some counter torque needs to be added if no dampening is added
	
	# This turns the body in the offset in the y direction around the x axis
	# and the offset in the x direction around the y axis 
	add_torque((local.y * global_transform.basis.x * pitch + -local.x * global_transform.basis.y * yaw))
	
# Additional keyboard controls
func keyboardMove(delta):
	if(Input.is_key_pressed(KEY_E)):
		add_torque(global_transform.basis.y * -1 * 20);
	if(Input.is_key_pressed(KEY_Q)):
		add_torque(global_transform.basis.y * 1 * 20);
		
	if(Input.is_key_pressed(KEY_W)):
		add_torque(global_transform.basis.x * -1 * 20);
	if(Input.is_key_pressed(KEY_S)):
		add_torque(global_transform.basis.x * 1 * 20);
		
	if(Input.is_key_pressed(KEY_D)):
		add_torque(global_transform.basis.z * -1 * 20);
	if(Input.is_key_pressed(KEY_A)):
		add_torque(global_transform.basis.z * 1 * 20);
	
	if(Input.is_key_pressed(KEY_SPACE)):
		add_central_force(-global_transform.basis.z * 15);
