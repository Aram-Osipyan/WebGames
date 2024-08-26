extends Node

signal keyboard_clicked(letter)
signal backspace
signal complete
signal updated_current_word(word)
signal updated_keyboard_theme
signal game_over(result)

var Token:String
var Host:String = "http://localhost:8000"
var keys_theme = {}

func url(path):
	return Host + path

func keyboard_click(letter):
	print('global click')
	emit_signal("keyboard_clicked", letter)

func backspace_click():
	emit_signal("backspace")
	
func update_current_word(word):
	emit_signal("updated_current_word", word)

func complete_clicked():
	emit_signal("complete")

func update_keyboard_theme():
	emit_signal("updated_keyboard_theme")

func make_game_over(result):
	emit_signal("game_over", result)
