extends Button

export var answer : String

var disabled_theme = preload("res://resources/answer_button_disabled_theme.tres")
var disabled_checked_theme = preload("res://resources/answer_button_disabled_checked_theme.tres")
var disabled_failed_theme = preload("res://resources/answer_button_disabled_failed_theme.tres")
var normal_theme = preload("res://resources/answer_button_normal_theme.tres")
var checked_theme = preload("res://resources/answer_button_checked_theme.tres")

func _ready():
	Global.connect("answer_selected", self, "answer_select")
	Global.connect("state_refreshed", self, "refresh_state")
	
	make_default()

func _pressed():
	Global.select_answer(answer)

func answer_select(answer):
	print(answer)
	
	disabled = true
	if answer != self.answer:
		theme = normal_theme
	else:
		theme = checked_theme
	
func refresh_state(state):
	if state.current_answer == null:
		make_default()
		return
	
	disabled = true
	if state.current_answer.selected_answer == self.answer:
		if state.current_answer.correct:
			theme = disabled_checked_theme
		else:
			theme = disabled_failed_theme 
	
func make_default():
	disabled = false
	theme = normal_theme
