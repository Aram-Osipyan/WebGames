extends VBoxContainer

var file
var file_dir = "res://assets/5-letter-words.json"
var data

var today_word
var line_active = 0

func _ready():
	load_data(file_dir)
	today_word = random_word()

	get_child(0).line_status = true
	connect_to_line()
	print(today_word)


func load_data(dir):
	file = FileAccess.open(dir, FileAccess.READ)
	
	data = JSON.parse_string(file.get_as_text())
	
func random_word():
	var random_id = randi() % data.size()
	var new_word = data[random_id]["word"].to_upper()
	
	return new_word

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
		await get_tree().create_timer(0.1).timeout
	change_line()

func change_line():
	if line_active < get_child_count() - 1:
		get_child(line_active).line_status = false
		line_active +=1
		get_child(line_active).line_status = true
	else:
		print("game_over")
	
	
	
	
	
	
	
	
	
	
