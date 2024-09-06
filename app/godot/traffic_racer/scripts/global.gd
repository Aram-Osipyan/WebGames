extends Node

signal input(event)
signal speed_changed(speed)

var speed = 1 setget set_speed, get_speed
 
func make_input(event):
	emit_signal("input", event)

func set_speed(value):
	speed = value
	emit_signal("speed_changed", speed)

func get_speed():
	return speed
