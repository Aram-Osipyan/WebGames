extends Panel

var tween
var out_tween:Tween
var game_over_tween:Tween

func _ready():
	$Pause.connect("pressed", self, "_on_pause_button_down")
	$PopupResume/VBoxContainer/ContinueButton.connect("pressed", self, "_on_resume_button_down")
	$PopupResume/VBoxContainer/MainMenuButton.connect("pressed", self, "_on_main_menu_button_pressed")
	$GameOver/VBoxContainer/MainMenuButton.connect("pressed", self, "_on_main_menu_button_pressed")
	
	$GameOver.visible = false
	Global.connect("game_over", self, "_on_game_over")
	
	$PopupResume.visible = false
	$PopupResume.pause_mode = Node.PAUSE_MODE_PROCESS
	$PopupResume.rect_pivot_offset = $PopupResume.rect_size / 2
	$GameOver.rect_pivot_offset = $PopupResume.rect_size / 2
	
	tween = Tween.new()
	out_tween = Tween.new()
	game_over_tween = Tween.new()
	
	tween.pause_mode = Node.PAUSE_MODE_PROCESS
	out_tween.pause_mode = Node.PAUSE_MODE_PROCESS
	game_over_tween.pause_mode = Node.PAUSE_MODE_PROCESS
	
	self.add_child(tween)
	self.add_child(out_tween)
	self.add_child(game_over_tween)
	

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

func _on_pause_button_down():
	print('pause')
	$Modulation.visible = true
	$PopupResume.rect_scale = Vector2(0.2, 0.2)
	$PopupResume.visible = true

	tween.remove_all()
	tween.interpolate_property($PopupResume, 'rect_scale', Vector2(0.2, 0.2), Vector2(1.2, 1.2), 0.2)
	tween.interpolate_property($PopupResume, \
		'rect_scale', \
		Vector2(1.2, 1.2), \
		Vector2(1, 1), \
		0.1, # duration
		0, 2,
		0.2 # delay
	)
	tween.interpolate_method(self, 'set_modulation', 0, 0.7, 0.2)
	
	tween.start()
	get_tree().paused = true

func _on_resume_button_down():
	$PopupResume.rect_scale = Vector2(0.2, 0.2)
	out_tween.remove_all()
	
	out_tween.interpolate_property($PopupResume, 'rect_scale', Vector2(1, 1), Vector2(0.2, 0.2), 0.2)
	
	out_tween.interpolate_method(self, 'set_modulation', 0.7, 0, 0.2)
	out_tween.start()
	out_tween.connect("tween_all_completed", self, "_on_popup_animation_end")
	
func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene('res://scenes/menu.tscn')
	Global.make_menu()
	
func _on_popup_animation_end():
	get_tree().paused = false
	$Modulation.visible = false
	$PopupResume.visible = false
	
func set_modulation(val):
	$Modulation.modulate = Color(1, 1, 1, val)

func _on_game_over():
	if Global.is_game_over():
		return
	$GameOver/ResultLabel.text = str(stepify(Global.distance / 1000.0, 0.01)) + ' km'
	$Modulation.visible = true
	$GameOver.visible = true
	$GameOver.rect_scale = Vector2(0.2, 0.2)
	$Pause.disabled = true
	game_over_tween.remove_all()
	
	game_over_tween.interpolate_property($GameOver, 'rect_scale', Vector2(0.2, 0.2), Vector2(1.2, 1.2), 0.2)
	game_over_tween.interpolate_property($GameOver, \
		'rect_scale', \
		Vector2(1.2, 1.2), \
		Vector2(1, 1), \
		0.1, # duration
		0, 2,
		0.2 # delay
	)
	game_over_tween.interpolate_method(self, 'set_modulation', 0, 0.7, 0.2)
	
	game_over_tween.start()














