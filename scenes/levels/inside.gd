# Include code from the parent class
extends LevelParent

# When a player enters the exit zone
func _on_exit_gate_area_body_entered(_body):
	# Tween is used for simple animations - here it freezes the player
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	# Wait 1s
	await get_tree().create_timer(1).timeout
	# Change of scene
	TransitionLayer.change_scene("res://scenes/levels/outside.tscn")
	
var doorPos1: Vector2 = Vector2(1000,200)
var doorPos2: Vector2 = Vector2(2120,200)
const doorSpeed = 400
	
func _process(delta):
	# Close the door
	if doorPos1.x < 1365:
		doorPos1.x += doorSpeed * delta
		$Decorations/Door.position = doorPos1
	if doorPos2.x > 1755:
		doorPos2.x -= doorSpeed * delta
		$Decorations/Door2.position = doorPos2
