extends HBoxContainer

var children

func _ready():
	Global.connect("state_refreshed", self, "refresh_state")
	children = get_children()

func refresh_state(state):
	print(state)
	print(state.total_questions)
	clear_container()
	set_total_segments(state.total_questions)
	set_completed_segments(state.current_question_index)
	
func clear_container():
	for item in children:
		item.set_default()
		item.visible = false

func set_total_segments(segments_count):
	for i in range(segments_count):
		children[i].visible = true
		children[i].set_default()

func set_completed_segments(current_question_index):
	for i in range(current_question_index + 1):
		children[i].set_completed()
