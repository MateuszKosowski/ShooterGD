extends Area2D

# Variable declarations/definitions
var rotation_speed: int = 4
var ava_options = ['laser', 'laser', 'laser', 'grenade', 'health']
var direction: Vector2
var distance: int = randi_range(300,100)

#Randomize type from array
var type = ava_options[randi()%len(ava_options)]

func _ready():
	
	# Depending on type change the Sprite2D color
	if type == 'laser':
		$Sprite2D.modulate = Color(0, 0.7, 1)	
	if type == 'grenade':
		$Sprite2D.modulate = Color(1, 0.2, 0.18)	
	if type == 'health':
		$Sprite2D.modulate = Color(0.39, 1, 0.35)
	
	#Tween to move and scale spawned items	
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1,1), 0.3).from(Vector2(0,0))

# Rotate the item every single frame		
func _process(delta):
	rotation += rotation_speed * delta

# When some body(player) collide with item add stats to him and delete item
func _on_body_entered(body):
	body.add_item(type)
	$AudioStreamPlayer2D.play()
	$Sprite2D.hide()
	await $AudioStreamPlayer2D.finished
	queue_free()
