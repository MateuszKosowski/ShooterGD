extends Node2D

# Class name
class_name LevelParent

var laser_scane: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scane: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")
	
# Create a laser	
func _on_player_laser(pos, direction):
	var laser = laser_scane.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)
	$UI.update_laser_text()
	
# Create a granade
func _on_player_grenade(pos, direction):
	var grenade = grenade_scane.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	$UI.update_grenade_text()

func _ready():
	#Update UI
	$UI.update_laser_text()
	$UI.update_grenade_text()
	
	# Connect signal 'open' for a group
	for container in get_tree().get_nodes_in_group('Container'):
		container.connect("open", _on_container_opened)
	
	# Rotate the player after the level loads
	var pos3: Vector2 = get_viewport().size
	Input.warp_mouse(Vector2(pos3.x / 2, pos3.y - 100))
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0)
	await get_tree().create_timer(0.8).timeout
	var tween2 = create_tween()
	tween2.tween_property($Player, "speed", 400, 0)

# When laser hits the crete or toilet, spawn item
func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred('add_child', item)
	

#Update player stats after getting some items
func _on_player_update_stats():
	$UI.update_laser_text()
	$UI.update_grenade_text()
