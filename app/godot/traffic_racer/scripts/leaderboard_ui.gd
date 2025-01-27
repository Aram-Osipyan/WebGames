extends Panel

var leaderboard_item = preload("res://scenes/leaderboard_item.tscn")
var leaderboard_items = []

func _ready():
	Global.connect("leaderboard_responsed", self, "_on_leaderboard_response")
	
	for i in range(10):
		var item_instance = leaderboard_item.instance()
		item_instance.visible = false
		
		$LeadersContainer.add_child(item_instance)
		leaderboard_items.append(item_instance)

func _on_leaderboard_response(response):
	var data = response['data']
	clear_container()
	
	for i in range(data.size()):
		var item_instance = leaderboard_items[i]
		var name = data[i]['name']
		var max_score = data[i]['max_score']
		
		item_instance.set_ui( \
			str(i), \
			name.right(len(name) - 4), \
			"%10.2f" % (max_score / 1000.0) \
		)
		
		item_instance.visible = true
		
func clear_container():
	for item in leaderboard_items:
		item.visible = false
