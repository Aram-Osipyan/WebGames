extends Node

var road_prefab = preload("res://assets/prefabs/road.tscn")
var player_controller_script = preload("res://scripts/player_controller.gd")
var player_prefab = preload("res://assets/prefabs/car01.tscn")

var roads = []

var move_speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = player_prefab.instance()
	player.set_script(player_controller_script)
	player.translation = Vector3(0, 0, 0)
	add_child(player)
	
	player.translation.z -= 2
	
	for i in 5:
		var inst = road_prefab.instance()
		
		inst.scale = Vector3(10,10,10)
		inst.translation = Vector3(0,0,i*10)
		
		add_child(inst)
		roads.append(inst)


func _process(delta):
	move_road(delta)


func move_road(delta):
	var forward = Vector3(0,0,1)
	for road in roads:
		road.translate(-1 * forward * delta * Global.speed)
		
		var current_pos = road.translation.z
		var length = 50
		var offset = -10
		
		var eps = current_pos - int(current_pos)
		var correct_pos = length - ((length - int(current_pos) + offset) % length - offset) + eps
		road.translation.z = correct_pos
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
