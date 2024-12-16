extends Panel

onready var elems = $HBoxContainer.get_children()

func _ready():
	Global.connect("refresh_stats", self, "refresh_stats")

	
func refresh_stats(response):
	for index in range(elems.size()):
		var response_elem = response['result'][index]
		response_elem['index'] = index + 1
		
		elems[index].set_unit(response['result'][index].result, response_elem.word, response_elem)
	
	if response['result'][elems.size() - 1].result == 'empty':
		elems[elems.size() - 1].set_last()
