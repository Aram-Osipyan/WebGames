extends HBoxContainer

export var states:Array

var children
# Called when the node enters the scene tree for the first time.
func _ready():
	children = get_children()
	Global.connect("popup", self, "on_popup")
	Global.connect("popup_close", self, "on_popup_close")

func on_popup():
	for index in children.size():
		var child = children[index]		
		child.change_status(states[index])
		
		yield(get_tree().create_timer(0.25), "timeout")

func on_popup_close():
	for index in children.size():
		var child = children[index]		
		child.change_status_no_anim(0)
