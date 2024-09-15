extends CharacterBody2D

#Decalration of signals
signal laser(pos, direction)
signal grenade(pos, direction)
signal update_stats

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 400
var speed: int = max_speed

func _process(_delta):
	
	#Input for movement
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	
	#Rotate player
	look_at(get_global_mouse_position())
	var player_direction = (get_global_mouse_position() - position).normalized()
	
	#Laser shooting input
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi()%laser_markers.size()]
		can_laser = false
		$LaserReloadTimer.start()
		laser.emit(selected_laser.global_position, player_direction)
	
	#Grenade throw
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_grenade = false
		$GrenadeReloadTimer.start()
		var pos = $LaserStartPositions.get_children()[0].global_position
		grenade.emit(pos, player_direction)
		
func _on_laser_reload_timer_timeout():
	can_laser = true

func _on_grenade_reload_timer_timeout():
	can_grenade = true

# Adding some stats depending on type of item
func add_item(type: String) -> void:
	if type == 'laser':
		if Globals.laser_amount <= 30:
			Globals.laser_amount += 20
		else:
			Globals.laser_amount = 50
		update_stats.emit()
	if type == 'grenade':
		if Globals.grenade_amount < 5:
			Globals.grenade_amount += 1
			update_stats.emit()
	if type == 'health':
		if Globals.health < 90:
			Globals.health += 10
		else:
			Globals.health = 100

func hit():
	print("Player was hit") 
