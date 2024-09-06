extends Spatial


var init_rot = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("input", self, "_process_input")
	print('player controller attached')
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.clamp_y_rotation()
	self.clamp_z_rotation()

func _process_input(input):
	print("_process_input",' ', input)
	
	match input:
		'left':
			translation.x += 0.08
			rotate_y(0.048)
			#rotate_z(-0.1)
			pass
		'right':
			translation.x -= 0.08
			rotate_y(-0.048)
			#rotate_z(0.1)
			pass

func clamp_y_rotation(step = 0.005):
	if abs(init_rot - rotation.y) > step:
		rotate_y(sign(init_rot - rotation.y) * 0.013)
		
func clamp_z_rotation(step = 0.005):
	if abs(init_rot - rotation.z) > step:
		rotate_z(sign(init_rot - rotation.z) * 0.010)
