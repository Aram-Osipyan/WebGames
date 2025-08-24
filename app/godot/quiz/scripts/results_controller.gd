extends Control

onready var score_value = $ScrollContainer/MainContainer/ResultsSection/ScoreContainer/ScoreValue
onready var questions_grid = $ScrollContainer/MainContainer/QuestionsSection/QuestionsGrid
onready var correct_value = $ScrollContainer/MainContainer/QuestionsSection/AnswersStats/CorrectAnswers/CorrectValue
onready var incorrect_value = $ScrollContainer/MainContainer/QuestionsSection/AnswersStats/IncorrectAnswers/IncorrectValue
onready var time_value = $ScrollContainer/MainContainer/TimeSection/TimeContainer/TimeValue
onready var play_again_button = $ScrollContainer/MainContainer/PlayAgainSection/PlayAgainContainer/PlayAgainContent/PlayAgainButton
onready var segment_template = preload("res://scenes/progress-bar-segment.tscn")

var game_data = null

func _ready():
	# Connect to global signals
	Global.connect("state_refreshed", self, "_on_state_refreshed")
	play_again_button.connect("pressed", self, "_on_play_again_pressed")
	
	# Hide initially
	visible = false

func _on_state_refreshed(state):
	if state.has("completed") and state.completed:
		game_data = state
		show_results()

func show_results():
	if not game_data:
		return
		
	visible = true
	
	# Update score/place - for now showing score as place
	score_value.text = str(game_data.score)
	
	# Update questions grid - create visual indicators for each question
	create_questions_grid()
	
	# Update answer statistics
	correct_value.text = str(game_data.correct_answers)
	var incorrect_answers = game_data.total_questions - game_data.correct_answers
	incorrect_value.text = str(incorrect_answers)
	
	# Update time - convert timestamp to readable format
	update_time_display()

func create_questions_grid():
	# Clear existing children
	for child in questions_grid.get_children():
		child.queue_free()

	var total_questions = game_data.total_questions if game_data.has("total_questions") else 10
	var correct_answers = game_data.correct_answers if game_data.has("correct_answers") else 0
	
	for i in range(total_questions):
		var segment = segment_template.instance()
		
		if i < correct_answers:
			segment.set_completed()
		else:
			segment.set_default()
		segment.rect_min_size = Vector2(35, 9)
		questions_grid.add_child(segment)

func update_time_display():
	var total_seconds = game_data.completed_at - game_data.created_at
	time_value.text = str(total_seconds)


func _on_play_again_pressed():
	# Emit signal to restart the game or navigate back
	Global.emit_signal("game_restart_requested")
	# For now, just hide the results screen
	visible = false

func hide_results():
	visible = false

