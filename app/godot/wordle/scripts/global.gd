extends Node

var token:String
var host:String = "http://localhost:8000"

var Host:String:
	get:
		return host

var Token:String:
	get:
		return token
	set(value):
		self.token = value

func url(path):
	return Host + path
