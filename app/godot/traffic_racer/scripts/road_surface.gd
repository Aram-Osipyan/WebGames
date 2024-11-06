extends Spatial

onready var mat

# Called when the node enters the scene tree for the first time.
func _ready():
	mat = $MeshInstance.get_surface_material(0)

func _process(delta):
	mat.set_shader_param("Speed", Vector3(0, - Global.speed * 0.001 ,0))
	mat.set_shader_param("Distance", Vector3(0,- Global.distance * 0.009,0))
	# mat.set_shader_param("Distance", Vector3(0,- Global.speed * 0.001,0))
