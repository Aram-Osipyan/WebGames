extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Panel2/Speed.text = "\n" + str(int(Global.speed)) + " kmh"
	$Panel2/Distance.text = "\n" + str(stepify(Global.distance / 1000.0, 0.01)) + ' km'



func _on_Button3_button_down():
	var ev = InputEventAction.new()
	# Set as ui_left, pressed.
	ev.action = "ui_left"
	ev.pressed = true
	# Feedback.
	Input.parse_input_event(ev)

func _on_left_button_up():
	var ev = InputEventAction.new()
	# Set as ui_left, pressed.
	ev.action = "ui_left"
	ev.pressed = false
	# Feedback.
	Input.parse_input_event(ev)


func _on_Button2_button_down():
	var ev = InputEventAction.new()
	# Set as ui_left, pressed.
	ev.action = "ui_right"
	ev.pressed = true
	# Feedback.
	Input.parse_input_event(ev)

func _on_right_button_up():
	var ev = InputEventAction.new()
	# Set as ui_left, pressed.
	ev.action = "ui_right"
	ev.pressed = false
	# Feedback.
	Input.parse_input_event(ev)



func _on_break_button_up():
	var ev = InputEventAction.new()
	# Set as ui_left, pressed.
	ev.action = "ui_select"
	ev.pressed = false
	# Feedback.
	Input.parse_input_event(ev)

func _on_break_button_down():
	var ev = InputEventAction.new()
	# Set as ui_left, pressed.
	ev.action = "ui_select"
	ev.pressed = true
	# Feedback.
	Input.parse_input_event(ev)
