extends VBoxContainer

var line_active = 0
var current_word = ""

func _ready():
	Global.connect("keyboard_clicked", self, "_keyboard_click")
	Global.connect("backspace", self, "_backspace_click")
	Global.connect("complete", self, "_complete_click")
	
	
	var web_hash = "http://localhost:8000/games/55244f0e45592c5d70ad7207f77df63d/wordle/"#JavaScript.eval("window.location.href")	
	var token = web_hash.split('/')[4]
	Global.Token = token

	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")	
	var headers = ["Authorization: {token}".format({"token": token})]	
	http_request.request(Global.url("/wordle/state"), headers)
	
	
	
func _http_request_completed(result, response_code, headers, body):
	var response = JSON.parse(body.get_string_from_utf8()).result
	print(response)
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	var field = response.game_state.field
	if field == null:
		return
	var game_state = response.game_state
	draw_field(field)
	if game_state.result == 'win' || game_state.result == 'lose':
		Global.make_game_over(game_state.result)
	

func draw_field(field):
	change_line_by_number(field.size())
	
	yield(get_tree().create_timer(0.2), "timeout")
	for line_index in range(field.size()):
		var line_obj = get_child(line_index)
		var line = field[line_index]

		for index in range(line.state.size()):
			var cell = line_obj.get_child(index)
			cell.change_status(line.state[index])

			yield(get_tree().create_timer(0.1), "timeout")

			cell.text = line.word[index]
	update_field(field)
			

func update_field(field):
	change_line_by_number(field.size())
	current_word = ''
	for line_index in range(field.size()):
		var line_obj = get_child(line_index)
		var line = field[line_index]

		for index in range(line.state.size()):
			var cell = line_obj.get_child(index)
			cell.change_status_no_anim(line.state[index])
			cell.change_letter(line.word[index])
			Global.keys_theme[line.word[index]] = line.state[index]
	Global.update_keyboard_theme()


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
	if current_word.length() < 5:
		return
	var http_request = HTTPRequest.new()
	add_child(http_request)

	http_request.connect("request_completed", self, "_state_create_request")
	var headers = ["Authorization: {token}".format({"token": Global.Token}), "Content-Type: application/json"]
	
	var query = JSON.print({"word": current_word})
	print(query)
	
	var error = http_request.request(Global.url("/wordle/state"), headers, true, HTTPClient.METHOD_POST, query)
	print("complete")
	
func _state_create_request(result, response_code, headers, body):
	var response = JSON.parse(body.get_string_from_utf8()).result

	if response_code == 200:
		var game_state = response.game_state
		
		if game_state.result == 'pending' || game_state.result == null:
			var current_line = game_state.field[game_state.field.size() - 1]
			var active_line = get_child(line_active)
			for i in range(5):
				var child = active_line.get_child(i)
				child.change_status(current_line.state[i])
				yield(get_tree().create_timer(0.1), "timeout")
				child.change_letter(current_line.word[i])
		elif game_state.result == 'win' || game_state.result == 'lose':
			Global.make_game_over(game_state.result)
		
		update_field(game_state.field)
	elif response_code == 410:
		get_child(line_active).animate_error()
	
	
	
	
	
	
	
	
	
	
	
