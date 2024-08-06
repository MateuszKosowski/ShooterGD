extends Node2D

# Class name
class_name LevelParent

var laser_scane: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scane: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
	
# Create a laser	
func _on_player_laser(pos, direction):
	var laser = laser_scane.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)
	
# Create a granade
func _on_player_grenade(pos, direction):
	var grenade = grenade_scane.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)

func _ready():
	# Rotate the player after the level loads
	var pos3: Vector2 = get_viewport().size
	Input.warp_mouse(Vector2(pos3.x / 2, pos3.y - 100))
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0)
	await get_tree().create_timer(0.8).timeout
	var tween2 = create_tween()
	tween2.tween_property($Player, "speed", 400, 0)
