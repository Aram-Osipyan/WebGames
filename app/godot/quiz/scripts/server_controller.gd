extends Node

var state_request : HTTPRequest
var game_state = null

func _ready():
	state_request = HTTPRequest.new()
	state_request.connect("request_completed", self, "state_request_completed")
	
	Global.connect("answer_selected", self, 'submit_answer')
	Global.connect("next_selected", self, 'next')

	add_child(state_request)
	load_game_state()

func load_game_state():
	var url = Global.url("/quiz/state")
	var headers = ["Content-Type: application/json", "Authorization: " + Global.Token]
	state_request.request(url, headers, false, HTTPClient.METHOD_GET)

func state_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	if response_code == 200:
		var json_response = JSON.parse(body.get_string_from_utf8())
		print(json_response)
		if json_response.error == OK:
			game_state = json_response.result
			Global.refresh_state(game_state)

func submit_answer(answer):
	var url = Global.url("/quiz/state")
	var headers = ["Content-Type: application/json", "Authorization: " + Global.Token]
	
	var data = {
		"answer": answer,
		"question_id": game_state.current_question.id,
		"time_taken": 1,
		"hint_used": false
	}
	
	state_request.request(url, headers, false, HTTPClient.METHOD_POST, JSON.print(data))

func next():
	var url = Global.url("/quiz/state/next")
	var headers = ["Content-Type: application/json", "Authorization: " + Global.Token]
	state_request.request(url, headers, false, HTTPClient.METHOD_POST)














