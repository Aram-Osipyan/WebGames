extends Node

signal question_loaded(question_data)
signal answer_selected(answer)
signal hint_requested
signal game_completed(results)
signal timer_updated(time_left)
signal score_updated(score)
signal progress_updated(progress)
signal state_refreshed(stats)

var Token: String
var Host: String = "http://localhost:8000"
var current_question = null
var current_game_data = null
var timer_running = false
var question_start_time = 0

func _ready():
	var web_hash = JavaScript.eval("window.location.href")
	Global.Host = JavaScript.eval("window.location.origin")

	var token = web_hash.split('/')[4]
	Global.Token = token
	pass

func url(path):
	return Host + path

func load_question(question_data):
	current_question = question_data
	question_start_time = OS.get_ticks_msec()
	emit_signal("question_loaded", question_data)

func select_answer(answer):
	var time_taken = (OS.get_ticks_msec() - question_start_time) / 1000
	emit_signal("answer_selected", answer)
	
func request_hint():
	emit_signal("hint_requested")
	
func refresh_state(state):
	emit_signal("state_refreshed", state)

func complete_game(results):
	emit_signal("game_completed", results)

func update_timer(time_left):
	emit_signal("timer_updated", time_left)

func update_score(score):
	emit_signal("score_updated", score)

func update_progress(progress):
	emit_signal("progress_updated", progress)

func get_time_taken():
	return (OS.get_ticks_msec() - question_start_time) / 1000
