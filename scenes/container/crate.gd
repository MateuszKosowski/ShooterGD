extends ItemContainer

# Function called, when some obj collide with it
func hit():
	if not opened:
		# Hide lid after hit
		$LidSprite.hide()
		
		for i in range(4):
			#Get random Mark2D as a spawnpoint for item
			var pos = $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
			
			#Emit signal with pos and current_direction (variable from parent node - item_container)
			open.emit(pos, current_direction)
			
		opened = true

