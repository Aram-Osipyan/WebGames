extends Button

func _ready():
	connect("pressed", self, "on_button_click")

func on_button_click():
	request_for_price()
	
func request_for_price():
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")
	var headers = ["Authorization: {token}".format({"token": Global.Token})]	
	http_request.request(Global.url("/wordle/price"), headers)

	
func _http_request_completed(result, response_code, headers, body):
	print(response_code)
	if response_code != 200:
		return
	var response = JSON.parse(body.get_string_from_utf8()).result
	print(body.get_string_from_utf8())
	print(JSON.parse(body.get_string_from_utf8()))
	print(response)
	Global.refresh_stats(response)
