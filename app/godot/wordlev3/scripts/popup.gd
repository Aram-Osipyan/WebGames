extends Panel

var popup_tween
var close_tween
onready var height = OS.get_window_size().y

func _ready():
	popup_tween = Tween.new()
	close_tween = Tween.new()
	#popup_tween.interpolate_property(self, '')
	self.add_child(popup_tween)
	self.add_child(close_tween)
	
	#Global.connect("popup", self, "popup")
	#Global.connect("popup_close", self, "close")
	
	self.rect_position.y = height

func popup():
	popup_tween.remove_all()
	popup_tween.interpolate_method(self, \
		"set_position", \
		Vector2(0, height), \
		Vector2(0, 140), 0.4, 3)
	popup_tween.interpolate_method(self, \
		"set_position", \
		Vector2(0, 140), \
		Vector2(0, 170), 0.15, 1, 0, 0.4)
	popup_tween.start()
	
	#self.set_position(Vector2(0,160))
func close():
	close_tween.remove_all()
	close_tween.interpolate_method(self, \
		"set_position", \
		Vector2(0, 170), \
		Vector2(0, height), 0.15, 1, 0, 0)
	close_tween.start()

func _on_info_button_pressed():
	popup()
	Global.make_popup()
	
func _on_close_button_pressed():
	close()
	Global.make_popup_close()
	


