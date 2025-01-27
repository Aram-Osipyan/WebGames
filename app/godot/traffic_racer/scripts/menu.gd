extends Spatial

var prefabs = []

var leaderboard_popup:Tween
var leaderboard_close:Tween

func _ready():
	for prefab in Global.player_prefabs:
		var inst = prefab.instance()
		prefabs.append(inst)
		inst.translation = Vector3(0, 2.275, 0)
		inst.scale = Vector3(0.35, 1.33, 0.35)
		inst.visible = false
		
		$Pedestal.add_child(inst)
	prefabs[Global.choosed_prefab].visible = true
	
	$Panel/Right.connect("pressed", self, 'choose_next')
	$Panel/Left.connect("pressed", self, 'choose_previous')
	$Panel/HBoxContainer/Play_Button.connect("pressed", self, "play")
	$Panel/HBoxContainer/Leaderboard.connect("pressed", self, "leaderboard_popup")
	$Panel/Leaderboard/Close.connect("pressed", self, "leaderboard_close")
	
	leaderboard_popup = Tween.new()
	leaderboard_close = Tween.new()
	#popup_tween.interpolate_property(self, '')
	self.add_child(leaderboard_popup)
	self.add_child(leaderboard_close)

func _process(delta):
	$Pedestal.rotate_y(+.003)

func choose_prefab(index:int):
	for prefab in prefabs:
		prefab.visible = false
	prefabs[index].visible = true

func choose_next():
	Global.choosed_prefab = (Global.choosed_prefab + 1) % len(Global.player_prefabs)
	
	choose_prefab(Global.choosed_prefab)

func choose_previous():
	Global.choosed_prefab = (Global.choosed_prefab - 1 + len(Global.player_prefabs)) % len(Global.player_prefabs)
	
	choose_prefab(Global.choosed_prefab)

func play():
	Global.make_game()
	get_tree().change_scene('res://scenes/main.tscn')
	
func leaderboard_popup():
	Global.make_leaderboard_popup()
	
	leaderboard_popup.remove_all()
	leaderboard_popup.interpolate_method($Panel/Leaderboard, \
		"set_position", \
		Vector2(0, OS.get_window_size().y), \
		Vector2(0, 40), 0.4, 3)
	leaderboard_popup.interpolate_method($Panel/Leaderboard, \
		"set_position", \
		Vector2(0, 40), \
		Vector2(0, 70), 0.15, 1, 0, 0.4)
	leaderboard_popup.start()
	
	#self.set_position(Vector2(0,160))
func leaderboard_close():
	leaderboard_close.remove_all()
	leaderboard_close.interpolate_method($Panel/Leaderboard, \
		"set_position", \
		Vector2(0, 170), \
		Vector2(0, OS.get_window_size().y), 0.15, 1, 0, 0)
	leaderboard_close.start()
	
	
	
	
	
	
	
	

