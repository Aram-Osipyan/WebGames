extends Node

signal keyboard_clicked(letter)
signal backspace
signal complete_click
signal complete_send
signal complete_receive
signal updated_current_word(word)
signal updated_keyboard_theme
signal game_over(result)
signal popup
signal popup_close
signal refresh_stats(stats)


var Token:String
var Host:String = "http://51.250.36.233:8000"
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
	emit_signal("complete_click")
	
func complete_sent():
	emit_signal("complete_send")

func complete_received():
	emit_signal("complete_receive")
	
func update_keyboard_theme():
	emit_signal("updated_keyboard_theme")

func make_game_over(result):
	emit_signal("game_over", result)

func make_popup():
	emit_signal("popup")
	
func make_popup_close():
	emit_signal("popup_close")
	
func refresh_stats(stats):
	emit_signal("refresh_stats", stats)
	
	
	
	
	
	
	
	
	
