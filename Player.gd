extends KinematicBody2D

export (int) var speed = 200
export (int) var backwards_speed = 100
export var weapon = 0

var velocity = Vector2()

func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed('down'):
		velocity = Vector2(-backwards_speed, 0).rotated(rotation)
	elif Input.is_action_pressed('up'):
		velocity = Vector2(speed, 0).rotated(rotation)
		$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("click"):
		$AnimatedSprite.play("handgun")	
	else:
		$AnimatedSprite.play("unarmed_idle")
		
		

func switch_weapons():
	if Input.is_action_pressed("scroll_wheel_up") && weapon >= 0:
		weapon += 1
	if Input.is_action_pressed("scroll_wheel_down"):
		weapon -= 1 && weapon <= 1	

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
func _process(delta):
	switch_weapons()
