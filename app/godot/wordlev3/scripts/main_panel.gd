extends Panel

var tween

func _ready():
	Global.connect("popup", self, "on_popup")
	Global.connect("popup_close", self, "on_popup_close")
	
	tween = Tween.new()
	self.add_child(tween)
	

func on_popup():
	#tween.remove_all()
	#self.rect_position = Vector2(10,10)
	tween.interpolate_method(self, 'set_modulation', 1, 0.2, 0.4)
	tween.start()
	#self.modulate = '#3e3e3e'
	
func on_popup_close():
	self.modulate = Color.white

func set_modulation(val):
	self.modulate = Color(val, val, val, 1)
