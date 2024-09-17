extends Node

var road_prefab = preload("res://assets/prefabs/roads/Highway Straight 3.tscn")
var road_prefabs = [
	{
		'prefab': preload("res://assets/prefabs/roads/Highway Straight 3.tscn"),
		'weight': 0.6,
		'count': 2
	},
	{
		'prefab': preload("res://assets/prefabs/roads/Highway Straight 2.tscn"),
		'weight': 0.9,
		'count': 2
	},
	{
		'prefab': preload("res://assets/prefabs/roads/Highway Bridge 2.tscn"),
		'weight': 1,
		'count': 2
	}
]

var roads = []

var part_length = 129
var parts_count = 2
var length = part_length * parts_count
var offset = -5

var lands = []

var prefab_index = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in parts_count:
		var inst = road_prefab.instance()
		
		inst.scale = Vector3(0.65,1,1)
		inst.translation = Vector3(0,0,i * part_length)
		
		add_child(inst)
		roads.append(inst)
	
	for prefab in road_prefabs:
		prefab['instances'] = []
		for i in prefab['count']:
			var instance = prefab['prefab'].instance()
		
			instance.scale = Vector3(0.65,1,1)
			instance.visible = false
			prefab['instances'].append(instance)
			add_child(instance)
	

func _process(delta):
	move_road(delta)

func get_road():
	prefab_index += 1
	var random_float = randf()
	for prefab in road_prefabs:
		if random_float < prefab['weight']:
			return prefab['instances'][prefab_index % prefab['count']]

func move_road(delta):	
	for i in len(roads):
		var road = roads[i]
		(road as KinematicBody).move_and_collide(Vector3.FORWARD * delta * Global.speed * 0.2)
		
		var current_pos = road.translation.z
		
		if current_pos < offset:
			road.visible = false
			road = get_road()
			roads[i] = road
			road.visible = true
		
		var correct_pos = length - (fmod(length - current_pos + offset, length)  - offset)
		road.translation.z = correct_pos
		
