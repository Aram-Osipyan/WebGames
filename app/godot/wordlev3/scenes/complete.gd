extends Label

var default = load("res://assets/complete_default.tres")
var yellow = load("res://assets/complete_yellow.tres")
var label_default = load("res://assets/complete_label_default.tres")
var label_yellow = load("res://assets/complete_label_yellow.tres")


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("updated_current_word", self, "update_current_word")

func update_current_word(word):
	if len(word) >= 5:
		theme = yellow
		$CenterContainer/Label.theme = label_yellow
	else:
		theme = default
		$CenterContainer/Label.theme = label_default
		


func _on_Button_pressed():
	Global.complete_clicked()
