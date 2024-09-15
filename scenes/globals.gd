extends Node

signal health_change

var laser_amount = 50
var grenade_amount = 5
var can_get_hit = true

var health = 80: 
	get:
		return health
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if can_get_hit:
				health = value
				can_get_hit = false
				player_can_get_hit_timer()
		health_change.emit()

func player_can_get_hit_timer():
	await get_tree().create_timer(0.5).timeout
	can_get_hit = true

var player_pos: Vector2
