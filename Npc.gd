extends KinematicBody2D

var health = 30

func _ready():
	$AnimatedSprite.play("npc01_idle")

func _process(delta):
	if health <= 0:
		death()

func take_damage(dmgTaken):
	health -= dmgTaken
	
func death():
	$AnimatedSprite.play("npc01_death")
	$CollisionShape2D.queue_free()
