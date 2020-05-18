extends KinematicBody2D

export (int) var speed = 200
export (int) var backwards_speed = 100
export (float) var rotation_speed = 2.5
export var weapons = ["unarmed", "handgun"]
var selected_weapon = weapons[0]

var velocity = Vector2()
var rotation_dir = 0
var Bullet = preload("res://Bullet.tscn")

signal shoot(type, direction, location)

func _ready():
	print("ready")

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		rotation_dir += 1
	if Input.is_action_pressed('left'):
		rotation_dir -= 1
	if Input.is_action_pressed('down'):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed('up'):
		velocity = Vector2(speed, 0).rotated(rotation)
		if selected_weapon == weapons[0]:
			$AnimatedSprite.play("walk")
		#elif selected_weapon == weapons[1]:
			#$AnimatedSprite.play("nightstick_move")
		elif selected_weapon == weapons[1]:
			$AnimatedSprite.play("handgun_run_n_gun")
	else:
		if selected_weapon == weapons[0]:
			$AnimatedSprite.play("unarmed_idle")
		#elif selected_weapon == weapons[1]:
			#$AnimatedSprite.play("nightstick_idle")
		elif selected_weapon == weapons[1]:
			$AnimatedSprite.play("handgun_idle")
		

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)

func switch_weapons():
	if Input.is_action_just_pressed("prev_weapon"):
		if selected_weapon == weapons[weapons.size() - 1]:
			selected_weapon = weapons[0]
		else:
			var index = weapons.find(selected_weapon)
			selected_weapon = weapons[index + 1]
			
func shoot():
	if Input.is_action_just_pressed("attack"):
		if selected_weapon == weapons[1]:
			emit_signal("shoot", Bullet, rotation, position)
		
func _process(delta):
	shoot()
	switch_weapons()
