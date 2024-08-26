extends Panel

var keys:Array = []

var bg_default = load("res://assets/bg_default_key.tres")
var bg_gray = load("res://assets/bg_gray_key.tres")
var bg_green = load("res://assets/bg_green_key.tres")
var bg_yellow = load("res://assets/bg_yellow_key.tres")

var array_status = [bg_default, bg_gray, bg_green, bg_yellow]

func _ready():
	keys = $VBoxContainer/HBoxContainer.get_children() + \
		$VBoxContainer/HBoxContainer2.get_children() + \
		$VBoxContainer/HBoxContainer3.get_children()
	Global.connect("updated_keyboard_theme", self, "_update_themes")

func _update_themes():
	for i in range(keys.size()):
		var letter = keys[i].text
		if Global.keys_theme.has(letter):
			keys[i].theme = array_status[Global.keys_theme[letter]]
		
	
