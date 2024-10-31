extends Panel

onready var play_button = $Play_Button

var main_scene = 'res://scenes/main.tscn'

func _ready():
	play_button.connect("pressed", self, "play")


