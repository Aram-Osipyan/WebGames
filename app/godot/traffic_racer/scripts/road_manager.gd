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

var environment = [
	{
		'name': 'summer',
#		'land': preload('res://assets/prefabs/lands/land camping forest.tscn'),
		'rotation': Vector3(0, 0, 0),
		'scale': Vector3(1.4, 0.349, 1),
		'translation': Vector3(0, -1.921, 1.315)
	},
	{
		'name': 'autumn',
#		'land': preload("res://assets/prefabs/lands/land autumn atmosphere forest.tscn")
	},
	{
		'name': 'winter'
	}		
]

var roads = []

var part_length = 129
var parts_count = 2
var length = part_length * parts_count
var offset = -20

var current_env = environment[0]
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

#	for i in 3:
#		var land = current_env['land'].instance()
#		land.scale = current_env['scale']
#		land.rotation_degrees = current_env['rotation']
#		land.translation = current_env['translation']
#		land.translation.z = i * 44
#		add_child(land)
#
#		lands.append(land)
	


func _process(delta):
	move_road(delta)
#	move_environment(delta)

func get_road():
	prefab_index += 1
	var random_float = randf()
	print(random_float)
	for prefab in road_prefabs:
		if random_float < prefab['weight']:
			return prefab['instances'][prefab_index % prefab['count']]

func move_road(delta):	
	var forward = Vector3(0,0,1)
	for i in len(roads):
		var road = roads[i]
		road.translate(-1 * forward * delta * Global.speed)
		
		var current_pos = road.translation.z
		
		if current_pos < offset:
			road.visible = false
			road = get_road()
			roads[i] = road
			road.visible = true
		
		var correct_pos = length - (fmod(length - current_pos + offset, length)  - offset)
		road.translation.z = correct_pos
		
func move_environment(delta):
	var forward = Vector3(0,0,1)
	var offset = -30
	var length = 3 * 44
	for land in lands:
		land.translate(-1 * forward * delta * Global.speed)
		
		var current_pos = land.translation.z	
		
		var correct_pos = length - (fmod(length - current_pos + offset, length)  - offset)
		land.translation.z = correct_pos
		
