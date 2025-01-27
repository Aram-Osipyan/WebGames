extends HBoxContainer

func _ready():
	pass # Replace with function body.

func set_ui(index, name, score):
	$Label.text = index
	$Panel/HBoxContainer/Label.text = name
	$Panel/HBoxContainer/Result.text = score
