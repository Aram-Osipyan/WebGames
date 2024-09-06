extends Node

signal input(event)

func make_input(event):
	emit_signal("input", event)
