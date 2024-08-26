extends Label

func _on_Button_pressed():
	print("button pressed")
	Global.keyboard_click(self.text)

