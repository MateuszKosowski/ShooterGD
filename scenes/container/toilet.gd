extends ItemContainer

func hit():
	if not opened:
		# Hide lid after hit
		$LidSprite.hide()
		
		#Get random Mark2D as a spawnpoint for item
		var pos = $SpawnPositions/Marker2D.global_position
	
		#Emit signal with pos and current_direction (variable from parent node - item_container)
		open.emit(pos, current_direction)
			
		opened = true

