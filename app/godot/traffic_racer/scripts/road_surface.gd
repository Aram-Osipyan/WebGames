extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var mat

# Called when the node enters the scene tree for the first time.
func _ready():
	mat = $MeshInstance.get_surface_material(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mat.set_shader_param("Speed", Vector3(0, - Global.speed * 0.001 ,0))
