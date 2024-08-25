extends VBoxContainer

var line_active = 0
var current_word = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("keyboard_clicked", self, "_keyboard_click")
	Global.connect("backspace", self, "_backspace_click")
	Global.connect("complete", self, "_complete_click")
	
	var web_hash = JavaScript.eval("window.location.href")
	
	var token = web_hash.split('/')[4]
	Global.Token = token

	var http_request = HTTPRequest.new()
	add_child(http_request)
	#http_request.request_completed.connect(self._http_request_completed)
	http_request.connect("request_completed", self, "_http_request_completed")
	
	var headers = ["Authorization: {token}".format({"token": token})]
	
	var error = http_request.request(Global.url("/wordle/state"), headers)
	
func _http_request_completed(result, response_code, headers, body):
	var response = JSON.parse(body.get_string_from_utf8()).result

	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	var field = response.game_state.field
	if field == null:
		return
	change_line_by_number(field.size())
	draw_field(field)

func draw_field(field):
	yield(get_tree().create_timer(0.2), "timeout")
	for line_index in range(field.size()):
		var line_obj = get_child(line_index)
		var line = field[line_index]

		for index in range(line.state.size()):
			var cell = line_obj.get_child(index)
			cell.change_status(line.state[index])

			yield(get_tree().create_timer(0.1), "timeout")

			cell.text = line.word[index]

func change_line_by_number(line_number):
	if line_number < get_child_count() - 1:
		line_active = line_number
	else:
		print("game_over")

func _keyboard_click(letter):
	if len(current_word) >= 5:
		return
	
	var line = get_child(line_active)	
	var cell = line.get_child(len(current_word))
	cell.pop_anim()

	current_word = current_word + letter
	update_current_word()
	
	
func update_current_word():
	var line = get_child(line_active)
	
	for cell_index in range(5):
		line.get_child(cell_index).change_letter("")
	for cell_index in range(len(current_word)):
		line.get_child(cell_index).change_letter(current_word[cell_index])
	
	Global.update_current_word(current_word)
	
func _backspace_click():
	print("backspace")
	if current_word.length() <= 0:
		return
	
	current_word.erase(current_word.length() - 1, 1)
	update_current_word()
	
func _complete_click():
	print("complete")
	
	
	
	
	
	
	
	
	
