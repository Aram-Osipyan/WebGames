extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_D:
				Global.make_input('right')
#				print('KEY_D')
			elif event.scancode == KEY_A:
				Global.make_input('left')
#				print('KEY_A')
			
