extends Button

var normal_theme = preload("res://resources/next_button/normal_theme.tres")
var disabled_theme = preload("res://resources/next_button/disabled_theme.tres")
var clicked_theme = preload("res://resources/next_button/clicked_theme.tres")

func _ready():
	Global.connect("state_refreshed", self, "refresh_state")

	make_default()

func make_default():
	disabled = true
	theme = disabled_theme

func refresh_state(state):
	if state.current_answer == null:
		make_default()
		return
	
	disabled = false
	theme = normal_theme

func _pressed():
	disabled = true
	theme = clicked_theme
	Global.select_next()
	
