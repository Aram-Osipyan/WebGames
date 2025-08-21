extends Panel

var default_theme = preload("res://resources/light_green.tres")
var completed_theme = preload("res://resources/green_segment.tres")

func set_completed():
	theme = completed_theme

func set_default():
	theme = default_theme
