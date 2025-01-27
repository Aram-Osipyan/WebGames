extends Node

enum GameState { MENU, GAME, GAME_OVER }

signal input(event)
signal speed_changed(speed)
signal game_over(game_state)
signal leaderboard_popup
signal leaderboard_responsed

var speed = 100 setget set_speed, get_speed

var distance = 0.0
 
var road_speed setget set_road_speed, get_road_speed

var game_state = GameState.MENU

var player_prefabs = [
	preload("res://assets/prefabs/car/car-sports.tscn"),
	preload("res://assets/prefabs/car/car-passenger-race.tscn"),
	preload("res://assets/prefabs/car/car-taxi-china.tscn")
]
var choosed_prefab = 0

var Token:String
var Host:String

func _ready():
	Host = JavaScript.eval("window.location.origin")
	var web_hash = JavaScript.eval("window.location.href")
	
	Global.Token = web_hash.split('/')[4]
	
	print('host: %s' % Host)
	print('token: %s' % Token)

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
	emit_signal("game_over", { "score": Global.distance})
	game_state = GameState.GAME_OVER

func make_menu():
	game_state = GameState.MENU

func make_game():
	game_state = GameState.GAME

func get_current_player_prefab():
	return player_prefabs[choosed_prefab]

func vibrate(duration):
	JavaScript.eval('Navigator.vibrate(100)', true)

func url(path):
	return Host + path

func make_leaderboard_popup():
	emit_signal("leaderboard_popup")

func make_leaderboard_responsed(response):
	emit_signal("leaderboard_responsed", response)

