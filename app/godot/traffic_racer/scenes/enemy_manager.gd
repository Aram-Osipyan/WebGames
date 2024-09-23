extends Node

var enemy_prefabs = [
	{
		"prefab": preload('res://assets/prefabs/car/car-passenger-race.tscn'),
		"weight": 1,
		"count" : 10
	},
	{
		"prefab": preload('res://assets/prefabs/car/car-taxi.tscn'),
		"weight": 1,
		"count" : 10
	},
	{
		"prefab": preload('res://assets/prefabs/car/car-passenger.tscn'),
		"weight": 5,
		"count" : 10
	},
	{
		"prefab": preload('res://assets/prefabs/car/car-taxi-china.tscn'),
		"weight": 2,
		"count" : 10
	},
	{
		"prefab": preload('res://assets/prefabs/car/car-police.tscn'),
		"weight": 1,
		"count" : 10
	},
	{
		"prefab": preload('res://assets/prefabs/car/jeep-open.tscn'),
		"weight": 1,
		"count" : 10
	}
]
var rng = RandomNumberGenerator.new()
var enemy_controller_script = preload("res://scripts/enemy_controller.gd")

var weights = []
var prefab_index = 0
var enemies = []


var spawn_pos_z = 40
var remove_pos_z = -8

var spawners = [-1.2, 1.2, 3.6, -3.6]

var delta_distance = 0
var spawn_current = 200

func _ready():
	enemy_prefabs.sort_custom(self, 'sort_by_weight')	
	enemy_weights()
	
	for prefab in enemy_prefabs:
		prefab['instances'] = []
		for i in prefab['count']:
			var instance = prefab['prefab'].instance()
		
			instance.scale = Vector3(1,1,1)
			instance.visible = false
			instance.translation = Vector3(10, 10, -10)
			(instance as KinematicBody).collision_layer = 3
			instance.set_script(enemy_controller_script)
			
			prefab['instances'].append(instance)
			add_child(instance)

func _process(delta):
	delta_distance += delta * Global.speed
	
	if delta_distance > spawn_current:
		_on_timer_timeout()
		delta_distance = 0
		spawn_current = rand_range(150, 400)
		
		
func enemy_weights():
	var sum = 0
	for conf in enemy_prefabs:
		sum += conf["weight"]
	
	var local_sum = 0
	for conf in enemy_prefabs:
		local_sum += conf['weight']
		weights.push_back(float(local_sum) / sum)
	
func sort_by_weight(a, b):
	if a["weight"] < b['weight']:
		return true
	return false
	
func get_enemy():
	prefab_index += 1
	var random_float = randf()
	for index in len(enemy_prefabs):
		var prefab = enemy_prefabs[index]
		if random_float >= weights[index]:
			continue
		for enemy in prefab['instances']:
			if enemy.is_hided():
				enemy.translation = Vector3(0,0,0)
				enemy.remove_tween()
				
				return enemy

func _physics_process(delta):
	var temp = []
	for index in len(enemies):
		var enemy = enemies[index]['enemy']
		var speed = enemy.speed
		
		var collider = (enemy as KinematicBody)\
			.move_and_collide(Vector3.FORWARD * delta * (Global.road_speed - speed))

		process_collider(collider, enemy, speed, delta)
		
		if   enemy.translation.z < remove_pos_z:
			enemy.hide()
		else:
			temp.append(enemies[index])
	enemies = temp

func process_collider(kinematic_collider: KinematicCollision, enemy, speed, delta):
	if kinematic_collider == null:
		return
	
	var collider = kinematic_collider.collider as KinematicBody
	if Global.speed > 120:
		Global.make_game_over()
		collider.move_and_collide(Vector3.FORWARD * delta * (Global.road_speed - speed))
	elif collider.collision_layer == 2:
		enemy.set_hazard_mode(1)
		Global.speed -= 2 
		
			
func _on_timer_timeout():
	var count = rng.randi_range(0,3)
	spawners.shuffle()
	for spawn_x_pos in spawners.slice(0, count - 1 ):
		var enemy = get_enemy()

		if enemy == null:
			continue
		
		enemy.make_idle()
		enemy.visible = true
		enemy.translation.z = spawn_pos_z
		enemy.translation.x = spawn_x_pos
		enemy.speed = rng.randf_range(7, 12)
		enemies.append({ 'enemy': enemy })
	
func get_rnd_from_array(array: Array):
	var i = rng.randi_range(0, len(array) - 1)
	
	return array[i]
























