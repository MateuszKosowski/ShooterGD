extends Node

signal health_change

var laser_amount = 50
var grenade_amount = 5
var health = 80: 
	get:
		return health
	set(value):
		health = value
		health_change.emit()

var player_pos: Vector2
