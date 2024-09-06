extends KinematicBody


var init_rot = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print('player controller attached')	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var velocity = Vector3.ZERO
	var rotate_velocity = 0.014
	if Input.is_action_pressed("ui_left"):
		rotate_y(rotate_velocity)
		velocity += Vector3.RIGHT * Global.speed * 3
	elif Input.is_action_pressed("ui_right"):
		rotate_y(-rotate_velocity)
		velocity += Vector3.LEFT * Global.speed * 3
	move_and_slide(velocity)
	clamp_y_rotation()


func clamp_y_rotation(step = 0.01):
	if abs(init_rot - rotation.y) > step:
		rotate_y(sign(init_rot - rotation.y) * 0.013)
