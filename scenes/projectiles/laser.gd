extends Area2D

@export var speed: int = 1500
var direction: Vector2 = Vector2.UP

func _ready():
		$SelfDestroy.start()

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if "hit" in body:
		body.hit()
	queue_free()
	
func _on_self_destroy_timeout():
	queue_free()
