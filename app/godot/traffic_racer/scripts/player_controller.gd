extends KinematicBody


var init_rot = 0
var init_z_pos


# Called when the node enters the scene tree for the first time.
func _ready():
	init_z_pos = translation.z
	
	# print('player controller attached')

func _process(delta):
	Global.distance += delta * Global.speed
		 
	
func _physics_process(delta):
	if Global.is_game_over():
		return
	
	var velocity = process_input()

	var collide = move_and_collide(velocity * delta)

	clamp_y_rotation()	
	process_collision(collide)
	_update_speed()
	clamp_z_position(delta)

func process_input():	
		
	var velocity = Vector3.ZERO
	var rotate_velocity = 0.014
	if Input.is_action_pressed("ui_left"):
		rotate_y(rotate_velocity)
		velocity += Vector3.RIGHT * Global.speed * 0.08
	elif Input.is_action_pressed("ui_right"):
		rotate_y(-rotate_velocity)
		velocity += Vector3.LEFT * Global.speed * 0.08
	elif Input.is_action_pressed("ui_select"):
		Global.speed -= 2
	return velocity

func clamp_y_rotation(step = 0.01):
	if abs(init_rot - rotation.y) > step:
		rotate_y(sign(init_rot - rotation.y) * 0.013)

func clamp_z_position(delta, step = 0.1):
	if abs(init_z_pos - translation.z) > step:
		move_and_collide(Vector3.BACK * sign(init_z_pos - translation.z) * delta)

func process_collision(kinematic_collision):
	if kinematic_collision == null:
		return
	
	var collider = kinematic_collision.collider
	# print('player controller: ' + str(collider as KinematicBody))
	
	var kinematic_body = collider
	if kinematic_body.collision_layer == 1: # if is road	
		Global.speed -= 2
		Global.vibrate(200)
	elif kinematic_body.collision_layer == 3: # if is enemy
		Global.speed -= 4
		Global.vibrate(200)
#		kinematic_b`.move_and_collide(Vector3.RIGHT *  sign(collider.translation.x - translation.x) * 0.08)
		collider.set_hazard_mode(sign(collider.translation.x - translation.x))

func _update_speed():
	if Global.speed < 150:
		Global.speed += 10.0 / Global.speed


	
func get_tween_node(node: Node) -> Tween:
	for child in node.get_children():
		if child is Tween:
			return child as Tween
	return null
	
