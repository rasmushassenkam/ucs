extends Area2D

var velocity = Vector2.ZERO

func _physics_process(delta):
	position += velocity * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()	


func _on_Bullet_body_entered(body):
	print("hit:", body.name)
	queue_free()
	body.take_damage(10)
