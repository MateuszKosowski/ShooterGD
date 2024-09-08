extends Area2D

var rotation_speed: int = 4
var ava_options = ['laser', 'laser', 'laser', 'grenade', 'health']
var type = 'health' #ava_options[randi()%len(ava_options)]

func _ready():
	
	if type == 'laser':
		$Sprite2D.modulate = Color(0, 0.7, 1)
		
	if type == 'grenade':
		$Sprite2D.modulate = Color(1, 0.2, 0.18)
		
	if type == 'health':
		$Sprite2D.modulate = Color(0.39, 1, 0.35)
		
func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(body):
	body.add_item(type)
	queue_free()
