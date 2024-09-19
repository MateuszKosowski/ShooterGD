extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var can_get_hit: bool = true
var one_gun_use: bool = true
var health: int = 100

signal laser(pos, direction)

func hit():
	if can_get_hit:
		health -= 20
		can_get_hit = false
		$Timers/HitTImer.start()
		
		# Shader in Godot is shared by all instances that use the same material
		# To solve this problem, you need to make sure that each enemy instance has its own unique copy of the material
		$Sprite2D.material = $Sprite2D.material.duplicate()
		$Sprite2D.material.set_shader_parameter("progress", 1)
		
		if health <= 0:
			queue_free()

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var marker_node = $LaserSpawnPositions.get_child(one_gun_use)
			one_gun_use = not one_gun_use
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$Timers/LaserCooldown.start()

func _on_attack_area_body_entered(_body):
	player_nearby = true

func _on_attack_area_body_exited(_body):
	player_nearby = false

func _on_hit_timer_timeout():
	can_get_hit = true
	$Sprite2D.material.set_shader_parameter("progress", 0)

func _on_laser_timer_timeout():
	can_laser = true
