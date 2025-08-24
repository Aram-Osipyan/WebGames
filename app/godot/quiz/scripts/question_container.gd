extends VBoxContainer

onready var question_label = $QuestionText

func _ready():
	Global.connect("state_refreshed", self, "refresh_state")

func refresh_state(state):
	question_label.text = state.current_question.question_text
