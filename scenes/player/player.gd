extends CharacterBody2D

#Decalration of signals
signal laser(pos)
signal grenade(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true

func _process(_delta):
	
	#Input for movement
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 400
	move_and_slide()
	
	#Rotate player
	look_at(get_global_mouse_position())
	
	#Laser shooting input
	if Input.is_action_pressed("primary action") and can_laser:
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi()%laser_markers.size()]
		can_laser = false
		$LaserReloadTimer.start()
		laser.emit(selected_laser.global_position)
	
	#Grenade throw
	if Input.is_action_pressed("secondary action") and can_grenade:
		can_grenade = false
		$GrenadeReloadTimer.start()
		var pos = $LaserStartPositions.get_children()[0].global_position
		var player_direction = (get_global_mouse_position() - position).normalized()
		grenade.emit(pos, player_direction)
		
func _on_laser_reload_timer_timeout():
	can_laser = true

func _on_grenade_reload_timer_timeout():
	can_grenade = true



