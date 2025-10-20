extends Control

onready var scroll_container = $ScrollContainer
onready var play_button_1 = $ScrollContainer/MainContainer/FirstSection/ContentContainer1/ButtonContainer1/PlayButton1
onready var play_button_2 = $ScrollContainer/MainContainer/SecondSection/ContentContainer2/ButtonContainer2/PlayButton2

func _ready():
	# Connect button signals
	play_button_1.connect("pressed", self, "_on_play_button_1_pressed")
	play_button_2.connect("pressed", self, "_on_play_button_2_pressed")

func _on_play_button_1_pressed():
	# Scroll to the second section
#	var second_section_position = 900  # Height of first section
#	scroll_container.scroll_vertical = second_section_position
	Global.start_autoscroll()

func _on_play_button_2_pressed():
	# Navigate to main quiz scene
	get_tree().change_scene("res://scenes/main.tscn")
