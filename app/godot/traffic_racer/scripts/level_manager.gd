extends Node

var player_controller_script = preload("res://scripts/player_controller.gd")
var player_prefab = preload("res://assets/prefabs/car05.tscn")


var move_speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = player_prefab.instance()
	player.set_script(player_controller_script)
	player.translation = Vector3(0, 0, 0)
	add_child(player)
	
	player.translation.z -= 2

