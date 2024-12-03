extends Panel

var popup_tween
var close_tween
onready var height = OS.get_window_size().y

func _ready():
	Global.connect("game_over", self, "game_over")
	
	popup_tween = Tween.new()
	close_tween = Tween.new()
	#popup_tween.interpolate_property(self, '')
	self.add_child(popup_tween)
	self.add_child(close_tween)
	
	self.rect_position.y = height

func popup():
	request_for_stats()
	popup_tween.remove_all()
	popup_tween.interpolate_method(self, \
		"set_position", \
		Vector2(0, height), \
		Vector2(0, 140), 0.4, 3)
	popup_tween.interpolate_method(self, \
		"set_position", \
		Vector2(0, 140), \
		Vector2(0, 170), 0.15, 1, 0, 0.4)
	popup_tween.start()
	
	#self.set_position(Vector2(0,160))
func close():
	close_tween.remove_all()
	close_tween.interpolate_method(self, \
		"set_position", \
		Vector2(0, 170), \
		Vector2(0, height), 0.15, 1, 0, 0)
	close_tween.start()

func _on_info_button_pressed():
	Global.make_popup()
	popup()
	
func _on_close_button_pressed():
	Global.make_popup_close()
	close()
		
func request_for_stats():
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
	print(body.get_string_from_utf8())
	print(JSON.parse(body.get_string_from_utf8()))
	print(response)
	Global.refresh_stats(response)

func game_over(result):
	popup()
	
