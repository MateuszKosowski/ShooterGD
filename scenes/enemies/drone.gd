extends CharacterBody2D

func _process(_delta):
	#direction
	var direction = Vector2(1,0)
	#velocity
	velocity = direction *300
	#move and slide
	move_and_slide()
	
