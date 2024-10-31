extends Spatial

var prefabs = []

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
	print('play')
	get_tree().change_scene('res://scenes/main.tscn')

