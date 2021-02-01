extends Spatial

var mouseHomingMultiplier : float = 0.01;
var mouseSensitivity : float = 0.001;

var mouseX : float;
var mouseY : float;

onready var target = $Target;

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);

func _input(event):
	if event is InputEventMouseMotion:
		mouseX = event.relative.x;
		mouseY = event.relative.y;
		rotate_y(-mouseX * mouseSensitivity);
		rotate_x(-mouseY * mouseSensitivity);
		
func _process(delta : float):
	rotate_x(-rotation.x * mouseHomingMultiplier);
	rotate_y(-rotation.y * mouseHomingMultiplier);
	
	# Reset mouse movement
	mouseX = 0;
	mouseY = 0;
