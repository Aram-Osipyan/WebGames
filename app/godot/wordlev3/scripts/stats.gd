extends Panel

onready var elems = $HBoxContainer.get_children()

func _ready():
	connect("visibility_changed", self, "visibility_changed")

func visibility_changed():

	if visible:
		var http_request = HTTPRequest.new()
		add_child(http_request)
		http_request.connect("request_completed", self, "_http_request_completed")
		var headers = ["Authorization: {token}".format({"token": Global.Token})]	
		http_request.request(Global.url("/wordle/stats"), headers)

func _http_request_completed(result, response_code, headers, body):
	print(response_code)
	if response_code != 200:
		return
	var response = JSON.parse(body.get_string_from_utf8()).result
	print(response)
	for index in range(elems.size()):
		var response_elem = response['result'][index]
		elems[index].set_unit(response['result'][index].result, response_elem.word, response_elem)
	
	elems[elems.size() - 1].set_last()
		
	
