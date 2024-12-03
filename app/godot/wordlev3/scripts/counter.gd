extends Panel

var seconds = 0
var timer
func _ready():
	timer = Timer.new()
	
	var unix_start = Time.get_unix_time_from_system() 
	var current_datetime = Time.get_datetime_dict_from_system()
	
	print(Time.get_datetime_dict_from_system())
	current_datetime.hour = 23
	current_datetime.minute = 59
	current_datetime.second = 59
	
	var unix_end = Time.get_unix_time_from_datetime_dict(current_datetime)
	
	seconds = unix_end - unix_start
	timer.set_wait_time(unix_end - unix_start) #value is in seconds: 600 seconds = 10 minutes
	add_child(timer) 
	timer.start() 

func _process(delta):
	var seconds = int(timer.time_left)
	var hours = seconds / 3600
	var minutes = (seconds % 3600) / 60
	var secs = (seconds % 3600) % 60
	$Label.text = "%02d : %02d : %02d" % [hours, minutes, secs]
	
	
	
	
	
	
	
	
	
	
	
	
	
	
