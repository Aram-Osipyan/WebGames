extends Control

var bg_color = ['#fcae1e', '#']

onready var modes = {
	'win': {
		'color': '#e55d09',
		'icon': $Done,
		'alter_label': $empty
	},
	'lose': {
		'color': '#414143',
		'icon': $IconLabel,
		'alter_label': $empty
	},
	'empty': {
		'color': '#414143',
		'icon': $IconLabel,
		'alter_label': $dots
	},
	'pending': {
		'color': '#414143',
		'icon': $Control2/bg_ring,
		'alter_label': $empty
	}
}

func _ready():
	$Done.visible = false

func set_unit(result, word, response_elem = null):
	var mode = modes['empty']

	if result != null:
		mode = modes[result]

	$IconLabel.text = str(response_elem['index'])
	$Control/bg_circle.modulate = mode['color']
	
	mode['alter_label'].visible = true	
	mode['icon'].visible = true
	
	if word != null:
		$Label.text = word

func set_last():
	$IconLabel.visible = false
	$Present.visible = true

