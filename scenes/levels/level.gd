extends Node2D

var laser_scane: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scane: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(body):
	print("player has entered gate")
	print(body)


func _on_player_laser(pos):
	var laser = laser_scane.instantiate()
	laser.position = pos
	$Projectiles.add_child(laser)



func _on_player_grenade(pos, direction):
	var grenade = grenade_scane.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
