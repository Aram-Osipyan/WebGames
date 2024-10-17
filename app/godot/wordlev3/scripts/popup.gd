extends Panel

var popup_tween
var close_tween

func _ready():
	popup_tween = Tween.new()
	close_tween = Tween.new()
	#popup_tween.interpolate_property(self, '')
	self.add_child(popup_tween)
	self.add_child(close_tween)
	
	
	
	
	
	Global.connect("popup", self, "popup")
	Global.connect("popup_close", self, "close")

func popup():
	popup_tween.remove_all()
	popup_tween.interpolate_method(self, \
		"set_position", \
		Vector2(0,1024), \
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
		Vector2(0, 1024), 0.15, 1, 0, 0)
	close_tween.start()

func _on_info_button_pressed():
	Global.make_popup()
	
func _on_close_button_pressed():
	Global.make_popup_close()
	


