extends HBoxContainer

var line_status = false

var word_input:String

signal word_to_container

func _input(event):
	if line_status == true:
		if (
			event.is_action_pressed("enter") and 
			word_input.length() == get_child_count()
		):
			print("enter")
			emit_signal("word_to_container", word_input)
		elif (
			event.is_action_pressed("backspace") and 
			word_input.length() > 0
			):
				word_input = word_input.erase(word_input.length() - 1, 1)				
				update_label()
				print("backspace")
		elif (
			event is InputEventKey and 
			!event.is_echo() and 
			event.is_pressed() and
			event.as_text().length() == 1 and
			word_input.length() < get_child_count()
		):
			word_input += event.as_text()
			update_label()
			get_child(word_input.length() - 1).pop_anim()
			print(word_input)
		elif event is InputEventKey:
			var ev = event as InputEventKey			
			if word_input.unicode_at(0) >= "А".unicode_at(0) and word_input.unicode_at(0) <= "Я".unicode_at(0):
				word_input += OS.get_keycode_string(ev.key_label)				
				update_label()
				get_child(word_input.length() - 1).pop_anim()
			print("А".unicode_at(0), "Я".unicode_at(0))
			print(ev.keycode)
			print(OS.get_keycode_string(ev.key_label))

func update_label():
	for i in range(get_child_count()):
		get_child(i).text = ""
	for i in range(word_input.length()):
		get_child(i).text ="Э" #word_input[i]
