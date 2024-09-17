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

var weights = []
var prefab_index = 0
var enemies = []

var timer:Timer = null

var spawn_pos_z = 40
var remove_pos_z = -8

var spawners = [-1.2, 1.2, 3.6, -3.6]

func _ready():
	enemy_prefabs.sort_custom(self, 'sort_by_weight')	
	enemy_weights()
	
	for prefab in enemy_prefabs:
		prefab['instances'] = []
		for i in prefab['count']:
			var instance = prefab['prefab'].instance()
		
			instance.scale = Vector3(1,1,1)
			instance.visible = true
			instance.translation = Vector3(10, 10, -10)
			(instance as KinematicBody).collision_layer = 3
			prefab['instances'].append(instance)
			add_child(instance)
	
	timer = Timer.new()
	timer.wait_time = 3
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)
	timer.start()

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

		if random_float < weights[index]:
			var enemy = prefab['instances'][prefab_index % prefab['count']]
			enemy.translation = Vector3(0,0,0)
			
			return enemy

func _physics_process(delta):
	var temp = []
	for index in len(enemies):
		var enemy = enemies[index]['enemy']
		var speed = enemies[index]['speed']
		
		var collider = (enemy as KinematicBody)\
			.move_and_collide(Vector3.FORWARD * Global.speed * speed * delta)

		process_collider(collider, speed, delta)
		
		if enemy.translation.z < remove_pos_z:
			hide_enemy(enemy)
		else:
			temp.append(enemies[index])
	enemies = temp

func process_collider(kinematic_collider: KinematicCollision, speed, delta):
	if kinematic_collider == null:
		return
	
	var collider = kinematic_collider.collider as KinematicBody
	if Global.speed > 120:
		collider.move_and_collide(Vector3.FORWARD * Global.speed * speed * delta)
		print("enemy manger: " + str(collider as KinematicBody))
	elif collider.collision_layer == 2:
		Global.speed -= 2 
		
func hide_enemy(enemy):
	enemy.visible = false			
	enemy.translation = Vector3(10, 10, -10)
			
func _on_timer_timeout():
	var count = rng.randi_range(0,3)
	spawners.shuffle()
	for spawn_x_pos in spawners.slice(0, count - 1 ):	
		var enemy = get_enemy()
		
		enemy.visible = true
		enemy.translation.z = spawn_pos_z
		enemy.translation.x = spawn_x_pos
	
		enemies.append({ 'enemy': enemy, 'speed': rng.randf_range(0.08, 0.2) })
	
	timer.wait_time = rng.randf_range(1,4)
	timer.start()
	
func get_rnd_from_array(array: Array):
	var i = rng.randi_range(0, len(array) - 1)
	
	return array[i]
