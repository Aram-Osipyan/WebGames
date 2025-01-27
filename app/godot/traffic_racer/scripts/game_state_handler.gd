extends Node

func _ready():
	Global.connect("game_over", self, "_on_game_over")
	Global.connect("game_over", self, "_reset_game_state")
	
	Global.connect("leaderboard_popup", self, "_on_leaderboard_popup")

func _on_game_over(game_state):
	var http_request = HTTPRequest.new()
	add_child(http_request)

	http_request.connect("request_completed", self, "_game_complete_response")
	var headers = ["Authorization: %s" % Global.Token, "Content-Type: application/json"]
	
	var query = JSON.print({"score": int(game_state['score'])})
	
	var error = http_request.request(Global.url("/racer/game_complete"), headers, true, HTTPClient.METHOD_POST, query)

func _game_complete_response(result, response_code, headers, body):
	pass

func _on_leaderboard_popup():
	var http_request = HTTPRequest.new()
	add_child(http_request)

	http_request.connect("request_completed", self, "_leaderboard_response")
	var headers = ["Authorization: %s" % Global.Token, "Content-Type: application/json"]
	
	var error = http_request.request(Global.url("/racer/leaderboard"), headers, true, HTTPClient.METHOD_GET)

func _leaderboard_response(result, response_code, headers, body):
	var response = JSON.parse(body.get_string_from_utf8()).result
	
	Global.make_leaderboard_responsed(response)

func _reset_game_state(game_state):
	Global.distance = 0

