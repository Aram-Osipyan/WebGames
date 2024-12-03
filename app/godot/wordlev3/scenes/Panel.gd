extends Panel

var panels

func _ready():
	Global.connect("game_over", self, "_set_panel")
	
	panels = {
		'win': $VBoxContainer/Panel/Win,
		'lose': $VBoxContainer/Panel/Lose
	}


func _set_panel(result):
	self.visible = true
	panels['win'].visible = false
	panels['lose'].visible = false
	
	panels[result].visible = true
