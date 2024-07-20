extends Node2D
class_name LevelParent

var laser_scane: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scane: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
	
var pos1: Vector2 = Vector2(1000,115)
var pos2: Vector2 = Vector2(2120,115)
const speed = 400
	
func _process(delta):
	if pos1.x < 1365:
		pos1.x += speed * delta
		$Door.position = pos1
	if pos2.x > 1755:
		pos2.x -= speed * delta
		$Door2.position = pos2
	
	
	
func _on_player_laser(pos, direction):
	var laser = laser_scane.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)


func _on_player_grenade(pos, direction):
	var grenade = grenade_scane.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 1)


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6), 1)
