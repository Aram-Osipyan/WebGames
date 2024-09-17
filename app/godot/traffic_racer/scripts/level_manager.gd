extends Node

var player_controller_script = preload("res://scripts/player_controller.gd")
var player_prefab = preload("res://assets/prefabs/car05.tscn")


var move_speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = player_prefab.instance()
	# (player as KinematicBody).set_collision_layer_bit(1<<1,true)
	(player as KinematicBody).collision_layer = 2
	(player as KinematicBody).collision_mask = 3
	print("collision_layer " + str((player as KinematicBody).collision_layer))
	player.set_script(player_controller_script)
	player.translation = Vector3(0, 0, 0)
	add_child(player)
	
	player.translation.z -= 2

