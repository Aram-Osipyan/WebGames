extends Label

var bg_default = load("res://assets/bg_default.tres")
var bg_gray = load("res://assets/bg_gray.tres")
var bg_green = load("res://assets/bg_green.tres")
var bg_yellow = load("res://assets/bg_yellow.tres")

var array_status = [bg_default, bg_gray, bg_yellow, bg_green]
# Called when the node enters the scene tree for the first time.
func _ready():
	change_status(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func change_status(status):
	$AnimationPlayer.play("flip")
	yield(get_tree().create_timer(0.3), "timeout")
	$AnimationPlayer.play("flip_back")
	theme = array_status[status]

func change_status_no_anim(status):
	theme = array_status[status]
	
func change_letter(letter):
	self.text = letter

func pop_anim():
	$AnimationPlayer.play("pop")
