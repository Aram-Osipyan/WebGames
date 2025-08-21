extends VBoxContainer

func _ready():
	Global.connect("state_refreshed", self, "refresh_state")

func refresh_state(state):
	var options = state.current_question.options
	
	$Answer1.text = options.A
	$Answer2.text = options.B
	$Answer3.text = options.C
	$Answer4.text = options.D
	
	print(state.total_questions)
