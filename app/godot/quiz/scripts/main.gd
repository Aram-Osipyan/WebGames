extends Control

#onready var timer_label = $VBoxContainer/HeaderContainer/TitleContainer/TimerContainer/TimerLabel
#onready var score_label = $VBoxContainer/ScoreContainer/ScoreLabel
#onready var question_title = $VBoxContainer/QuestionContainer/QuestionTitle
#onready var question_text = $VBoxContainer/QuestionContainer/QuestionText
#onready var buy_button = $VBoxContainer/OptionsContainer/BuyButton
#onready var islam_button = $VBoxContainer/OptionsContainer/IslamButton
#onready var next_button = $VBoxContainer/NextButton
#onready var shield_hint = $VBoxContainer/HintsContainer/ShieldHint
#onready var refresh_hint = $VBoxContainer/HintsContainer/RefreshHint
#onready var clock_hint = $VBoxContainer/HintsContainer/ClockHint
#onready var fifty_fifty_hint = $VBoxContainer/HintsContainer/FiftyFiftyHint
onready var http_request = $HTTPRequest

# Progress segments
#onready var segments = [
#	$VBoxContainer/HeaderContainer/ProgressContainer/ProgressBar/Segment1,
#	$VBoxContainer/HeaderContainer/ProgressContainer/ProgressBar/Segment2,
#	$VBoxContainer/HeaderContainer/ProgressContainer/ProgressBar/Segment3,
#	$VBoxContainer/HeaderContainer/ProgressContainer/ProgressBar/Segment4,
#	$VBoxContainer/HeaderContainer/ProgressContainer/ProgressBar/Segment5,
#	$VBoxContainer/HeaderContainer/ProgressContainer/ProgressBar/Segment6,
#	$VBoxContainer/HeaderContainer/ProgressContainer/ProgressBar/Segment7,
#	$VBoxContainer/HeaderContainer/ProgressContainer/ProgressBar/Segment8,
#	$VBoxContainer/HeaderContainer/ProgressContainer/ProgressBar/Segment9,
#	$VBoxContainer/HeaderContainer/ProgressContainer/ProgressBar/Segment10
#]

var current_question_data = null
var game_state = null
var question_timer = 30
var timer_active = false
var current_question_index = 0

func _ready():
	Global.connect("question_loaded", self, "_on_question_loaded")
	Global.connect("answer_selected", self, "_on_answer_selected")
	Global.connect("hint_requested", self, "_on_hint_requested")
	
	# Connect hint buttons
#	shield_hint.connect("pressed", self, "_on_hint_pressed", ["shield"])
#	refresh_hint.connect("pressed", self, "_on_hint_pressed", ["refresh"])
#	clock_hint.connect("pressed", self, "_on_hint_pressed", ["clock"])
#	fifty_fifty_hint.connect("pressed", self, "_on_hint_pressed", ["fifty_fifty"])
	
	# Connect answer buttons
#	buy_button.connect("pressed", self, "_on_option_selected", ["A"])
#	islam_button.connect("pressed", self, "_on_option_selected", ["B"])
#	next_button.connect("pressed", self, "_on_next_pressed")
	
	# Connect HTTP request
	http_request.connect("request_completed", self, "_on_HTTPRequest_request_completed")
	
	load_game_state()

func _process(delta):
	if timer_active and question_timer > 0:
		question_timer -= delta
		var minutes = int(question_timer) / 60
		var seconds = int(question_timer) % 60
#		timer_label.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
		if question_timer <= 0:
			_on_time_up()

func load_game_state():
	print('request')
	print(Global.Token)
	var url = Global.url("/quiz/state")
	var headers = ["Authorization: {token}".format({"token": Global.Token})]
	http_request.request(url, headers, false, HTTPClient.METHOD_GET)

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	print('response')

	print(response_code)
	if response_code == 200:
		var json_response = JSON.parse(body.get_string_from_utf8())
		print(json_response)
		if json_response.error == OK:
			game_state = json_response.result
			Global.refresh_state(game_state)
			update_ui()
			if game_state.has("current_question") and not game_state.completed:
				load_current_question()
			elif game_state.completed:
				show_completion_screen()

func update_ui():
	if game_state:
#		score_label.text = str(game_state.score) + " баллов"
		current_question_index = game_state.current_question_index
		update_progress_bar()
		
func update_progress_bar():
	pass
	#for i in range(segments.size()):
	#	if i < current_question_index:
	#		segments[i].color = Color(0.298039, 0.686275, 0.313726, 1) # Green
	#	else:
	#		segments[i].color = Color(0.8, 0.8, 0.8, 1) # Gray

func load_current_question():
	if game_state and game_state.has("current_question"):
		current_question_data = game_state.current_question
		Global.load_question(current_question_data)

func _on_question_loaded(question_data):
#	question_title.text = "Вопрос " + str(current_question_index + 1)
#	question_text.text = question_data.question_text
	
	# For now, show static options - in real implementation, these would be dynamic
#	buy_button.text = question_data.options.A if question_data.options.has("A") else "Вариант A"
#	islam_button.text = question_data.options.B if question_data.options.has("B") else "Вариант B"
	
	# Reset timer
	question_timer = 30
	timer_active = true
	
	# Enable all buttons
	set_buttons_enabled(true)

func _on_option_selected(answer):
	if not current_question_data:
		return
		
	set_buttons_enabled(false)
	timer_active = false
	
	var time_taken = Global.get_time_taken()
	submit_answer(answer, time_taken, false)

func _on_hint_pressed(hint_type):
	Global.request_hint()
	# Disable the used hint
#	match hint_type:
#		"shield":
#			shield_hint.disabled = true
#		"refresh":
#			refresh_hint.disabled = true
#		"clock":
#			clock_hint.disabled = true
#		"fifty_fifty":
#			fifty_fifty_hint.disabled = true

func _on_next_pressed():
	# Move to next question or complete game
	if current_question_index < 9:
		current_question_index += 1
		load_game_state()
	else:
		show_completion_screen()

func submit_answer(answer, time_taken, hint_used):
	var url = Global.url("/quiz/state")
	var headers = ["Content-Type: application/json", "Authorization: " + Global.Token]
	var data = {
		"answer": answer,
		"question_id": current_question_data.id,
		"time_taken": time_taken,
		"hint_used": hint_used
	}
	http_request.request(url, headers, false, HTTPClient.METHOD_POST, JSON.print(data))

func _on_time_up():
	timer_active = false
	set_buttons_enabled(false)
	# Auto-submit with no answer or random answer
	submit_answer("A", 30, false)

func set_buttons_enabled(enabled):
	pass
#	buy_button.disabled = not enabled
#	islam_button.disabled = not enabled

func show_completion_screen():
	# Show final results
#	question_title.text = "Игра завершена!"
#	question_text.text = "Поздравляем! Вы завершили викторину."
#	if game_state:
#		score_label.text = str(game_state.final_score) + " баллов"
#	next_button.text = "Играть завтра"
	set_buttons_enabled(false)
