extends Area2D

# Create signals
signal player_entered
signal player_exited

# Emit signals
func _on_body_entered(_body):
	player_entered.emit()
	
func _on_body_exited(_body):
	player_exited.emit()

