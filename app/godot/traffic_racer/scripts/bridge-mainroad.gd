extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var mat = get_surface_material(0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mat.set_shader_param("Speed", Vector3(0, - Global.speed * 0.001 ,0))
	mat.set_shader_param("Distance", Vector3(- Global.distance * 0.007,0,0))
