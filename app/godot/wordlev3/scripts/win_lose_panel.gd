extends Panel


var title_texts = {
	'pending': 'Вы отгадываете слово',
	'win': 'Вы отгадали слово!',
	'lose': 'Вы отгадали слово!'
}

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("refresh_stats", self, "refresh_stats")


func refresh_stats(response):
	var current_result = response['current_result']
	
	$Lose.text = title_texts[current_result]
