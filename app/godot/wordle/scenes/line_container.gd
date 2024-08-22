extends VBoxContainer

var file
var file_dir = "res://assets/5-letter-words.json"
var data

var today_word
var line_active = 0

func _ready():
	get_child(0).line_status = true
	connect_to_line()
	print(today_word)
	var web_hash = JavaScriptBridge.eval("window.location.href")
	
	var token = web_hash.split('/')[4]
	Global.Token = token
	
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)
	
	var headers = ["Authorization: {token}".format({"token": token})]
	
	var error = http_request.request(Global.url("/wordle/state"), headers)
	
func _http_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()

	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	print(response.headers["User-Agent"])
	print(json.get_data())
	print(json.get_data().game_state)
	var field = response.game_state.field
	if field == null:
		return
	change_line_by_number(field.size())
	draw_field(field)
	

func draw_field(field):
	await get_tree().create_timer(0.2).timeout
	for line_index in range(field.size()):
		var line_obj = get_child(line_index)
		var line = field[line_index]

		for index in range(line.state.size()):
			var cell = line_obj.get_child(index)
			cell.change_status(line.state[index])

			await get_tree().create_timer(0.1).timeout

			cell.text = line.word[index]

func connect_to_line():
	for i in range(get_child_count()):
		get_child(i).connect("word_to_container", Callable(self, "check_word"))

func check_word(word):
	print("check_word ", word)
	if word == today_word:
		check_letter(word)
		print("win")
	else:
		for i in range(data.size()):
			if word == data[i]["word"].to_upper():
				print("valid")
				check_letter(word)

func check_letter(word):
	var temp_word:String = today_word
	
	for i in range(today_word.length()):
		if word[i] == today_word[i]: # green right position
			get_child(line_active).get_child(i).change_status(2)
		elif word[i] in temp_word: # yellow wrong position
			get_child(line_active).get_child(i).change_status(3)
		else: # not available
			get_child(line_active).get_child(i).change_status(1)
		temp_word = temp_word.replace(word[i], "")
		await get_tree().create_timer(0.5).timeout
	change_line()

func change_line():
	if line_active < get_child_count() - 1:
		get_child(line_active).line_status = false
		line_active +=1
		get_child(line_active).line_status = true
	else:
		print("game_over")
		
func change_line_by_number(line_number):
	if line_number < get_child_count() - 1:
		get_child(line_active).line_status = false
		line_active = line_number
		get_child(line_number).line_status = true
	else:
		print("game_over")
	
	
	
	
	
	
	
	
	
	
