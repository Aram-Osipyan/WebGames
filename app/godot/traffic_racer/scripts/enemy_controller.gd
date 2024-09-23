extends KinematicBody
enum State { HIDED, IDLE, HAZARDED }

var speed = 0
onready var state = State.HIDED

var repeat_tween: Tween
var non_repeat_tween: Tween

func _ready():
	print('enemy controller attached')
	
	repeat_tween = Tween.new()
	self.add_child(repeat_tween)
	
	non_repeat_tween = Tween.new()
	self.add_child(non_repeat_tween)


func set_hazard_mode(rotation_sign:int):
	if state == State.HAZARDED:
		return
	
	var left = self.get_node('./left_light') as OmniLight
	var right = self.get_node('./right_light') as OmniLight
	
#	
	left.light_color = Color.yellow
	right.light_color = Color.yellow	
	
	repeat_tween.remove_all()
	repeat_tween.repeat = true
	repeat_tween.interpolate_property(left, "light_energy", 2, 0, 1, 1)
	repeat_tween.interpolate_property(right, "light_energy", 2, 0, 1, 1)
	
	non_repeat_tween.remove_all()
	non_repeat_tween.interpolate_property(self, "speed", speed, 0, 2, 0)
	
	non_repeat_tween.interpolate_property(self, 'rotation_degrees', self.rotation_degrees, self.rotation_degrees + Vector3(0, rotation_sign * 10, 0), 3)
	non_repeat_tween.interpolate_method(self, 'move_and_collide', Vector3.RIGHT * rotation_sign * 0.005, Vector3.LEFT * 0.005, 2,0)


	repeat_tween.start()
	non_repeat_tween.start()
	
	state = State.HAZARDED

func remove_tween():
	var left = self.get_node('./left_light') as OmniLight
	var right = self.get_node('./right_light') as OmniLight
	
	left.light_color = Color.red
	right.light_color = Color.red
	
	left.light_energy = 0.3
	right.light_energy = 0.3
		
	repeat_tween.remove_all()
	non_repeat_tween.remove_all()
	
	state = State.IDLE

func get_tween_node() -> Tween:
	for child in self.get_children():
		if child is Tween:
			return child as Tween
	return null

func is_hided():
	return state == State.HIDED

func make_idle():
	rotation_degrees = Vector3.ZERO
	translation = Vector3.ZERO
	state = State.IDLE
	
func hide():
	visible = false
	translation = Vector3(10, 10, -10)
	state = State.HIDED
