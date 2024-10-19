extends CharacterBody2D

var active: bool = false
var vulnerable: bool = true
var health: int = 50
var speed: int = 400

func _process(delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("explosion")
		
func _ready():
	$Explosion.hide()
	$Sprite2D.show()
	
func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$HitTimer.start()
	if health <= 0:
		$AnimationPlayer.play("explosion")
	
func _on_notice_area_body_entered(_body):
	active = true

func _on_hit_timer_timeout():
	vulnerable = true
