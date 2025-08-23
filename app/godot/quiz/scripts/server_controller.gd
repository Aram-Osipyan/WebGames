extends Node

var state_request : HTTPRequest
var game_state = null

func _ready():
	state_request = HTTPRequest.new()
	state_request.connect("request_completed", self, "state_request_completed")

	add_child(state_request)
	load_game_state()

func load_game_state():
	var url = Global.url("/quiz/state")
	var headers = ["Authorization: {token}".format({"token": Global.Token})]
	state_request.request(url, headers, false, HTTPClient.METHOD_GET)

func state_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	if response_code == 200:
		var json_response = JSON.parse(body.get_string_from_utf8())
		print(json_response)
		if json_response.error == OK:
			game_state = json_response.result
			Global.refresh_state(game_state)
