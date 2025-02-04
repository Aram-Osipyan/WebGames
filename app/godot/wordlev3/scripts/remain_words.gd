extends Panel

onready var word = {
	0: 'слов',
	1: 'слово',
	2: 'слова',
	3: 'слова',
	4: 'слова',
	5: 'слов',
}

func _ready():
	Global.connect("refresh_stats", self, "refresh_stats")

func refresh_stats(stats):
	var can_get_price = bool(stats['can_get_price'])
	var remain_day = int(stats['day_before_win'])
	
	
	$Button.visible = can_get_price
	
	if !can_get_price && remain_day == 0:
		$Label4.visible = true
		return
	else:
		$Label4.visible = false
	
	
	$InfoIcon.visible = !can_get_price
	$Label2.visible = !can_get_price
	$Label3.visible = !can_get_price
	
	

	$Label3.text = "Отгадайте еще %d %s" % \
		[ remain_day, word.get(remain_day, 'слов') ]
