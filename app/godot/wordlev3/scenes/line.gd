extends HBoxContainer

var default_theme = load("res://assets/bg_default.tres")
var error_theme = load("res://assets/bg_error.tres")
var children
func _ready():
	children = get_children()

func animate_error():

	for i in range(children.size()):
		children[i].theme = error_theme
	
	var tween = Tween.new()
	add_child(tween)
	
	var duration = 0.02
	var delay = duration
	var amplitude = 5
	tween.interpolate_property(self, "rect_position",
		Vector2(0, rect_position.y), Vector2(amplitude, rect_position.y), duration,
		Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	for i in range(5):
		tween.interpolate_property(self, "rect_position",
			Vector2(amplitude, rect_position.y), Vector2(-amplitude, rect_position.y), duration * 2,
			Tween.TRANS_EXPO, Tween.EASE_IN_OUT, delay)
		
		delay += duration * 2
		
		tween.interpolate_property(self, "rect_position",
			Vector2(-amplitude, rect_position.y), Vector2(amplitude, rect_position.y), duration * 2,
			Tween.TRANS_EXPO, Tween.EASE_IN_OUT, delay)
		
		delay += duration * 2
		
	tween.interpolate_property(self, "rect_position",
		Vector2(amplitude, rect_position.y), Vector2(0, rect_position.y), duration,
		Tween.TRANS_EXPO, Tween.EASE_IN_OUT, delay)
	tween.connect("tween_all_completed", self, "_animation_end")
	tween.start()
	

func _animation_end():
	for i in range(children.size()):
		children[i].theme = default_theme
	
