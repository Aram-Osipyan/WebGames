extends KinematicBody


var init_rot = 0
var init_z_pos
# Called when the node enters the scene tree for the first time.
func _ready():
	init_z_pos = translation.z
	print('player controller attached')

func _physics_process(delta):	
	var velocity = Vector3.ZERO
	var rotate_velocity = 0.014
	if Input.is_action_pressed("ui_left"):
		rotate_y(rotate_velocity)
		velocity += Vector3.RIGHT * Global.speed * 0.08
	elif Input.is_action_pressed("ui_right"):
		rotate_y(-rotate_velocity)
		velocity += Vector3.LEFT * Global.speed * 0.08
	var collide = move_and_collide(velocity * delta)
	
	clamp_y_rotation()	
	process_collision(collide)
	_update_speed()
	clamp_z_position(delta)

func clamp_y_rotation(step = 0.01):
	if abs(init_rot - rotation.y) > step:
		rotate_y(sign(init_rot - rotation.y) * 0.013)

func clamp_z_position(delta, step = 0.1):
	if abs(init_z_pos - translation.z) > step:
		move_and_collide(Vector3.BACK * sign(init_z_pos - translation.z) * delta)

func process_collision(kinematic_collision: KinematicCollision):
	if kinematic_collision == null:
		return
	
	var collider = kinematic_collision.collider
	
	if (collider as KinematicBody).collision_layer == 1:
		Global.speed -= 2

func _update_speed():
	if Global.speed < 150:
		Global.speed += 10.0 / Global.speed
