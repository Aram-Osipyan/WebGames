extends HBoxContainer

var start_timestamp = null
var timer_stopped = false

func _ready():
	Global.connect("state_refreshed", self, "refresh_state")

func _process(delta):
	if start_timestamp != null and !timer_stopped:
		var current_time = OS.get_unix_time()
		var elapsed = current_time - start_timestamp
		$TimerLabel.text = str(format_time(elapsed))

func format_time(seconds: int) -> String:
	var minutes = seconds / 60
	var secs = seconds % 60
	return str(minutes).pad_zeros(2) + ":" + str(secs).pad_zeros(2)

func refresh_state(state):
	start_timestamp = state.stopwatch_timestamp
	timer_stopped = state.current_answer != null
