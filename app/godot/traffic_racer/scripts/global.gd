extends Node

enum GameState { MENU, GAME, GAME_OVER }
signal input(event)
signal speed_changed(speed)

var speed = 100 setget set_speed, get_speed

var distance = 0.0
 
var road_speed setget set_road_speed, get_road_speed

var game_state = GameState.MENU

func get_road_speed():
	return Global.speed * 0.2
	
func set_road_speed(_value):
	pass

func make_input(event):
	emit_signal("input", event)

func set_speed(value):
	if value < 0:
		return
		
	speed = value
	emit_signal("speed_changed", speed)

func get_speed():
	return speed

func is_game_over():
	return game_state == GameState.GAME_OVER

func make_game_over():
	game_state = GameState.GAME_OVER

func vibrate(duration):
	JavaScript.eval('Navigator.vibrate(100)', true)

