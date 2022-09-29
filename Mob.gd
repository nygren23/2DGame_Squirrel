#enemy class So far there is only one time and they all do the same thing 
# they are set to follow the player
extends RigidBody2D

signal dies

export var speed = 0 # default speed is used for all enemies that spawn
var size = 0

onready var player = get_node("/root/Main/Player")
onready var main = get_node("/root/Main")
var health = 0
var attacking = false;
var cooldown = false;
var attackspeed = 0
var counter = 0
var direction = Vector2.ZERO

#chooses from an array of animation to used. So for there is only one animation.
func _ready():
	#sets the size and speed of the mob
	#size = 0.50
	speed = 90
	health = 400
	attackspeed = 300
	
	$AnimatedSprite.play()
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	var image = ('res://assets/enemy.png')
	
	

#moves the enemy and despawns them
func _process(delta):
	#var scale = Vector2((size), (size))
	#set_scale(scale)
	#if the game or round ends then the enemy despawns
	if(main.getSafe()):
		queue_free()
	
	if (player.position.x<position.x):
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	
	var movement_speed = 0
	if (attacking):
		movement_speed = attackspeed
		counter +=1
		if(counter == 15):
			counter = 0
			attacking = false
			cooldown = true
			
	#cooldown should be 2 seconds (assuming 60 fps)
	elif(cooldown):
		$AnimatedSprite.stop()
		counter +=1
		if(counter == 120):
			counter = 0
			cooldown = false
			$AnimatedSprite.play()
	
	else:
		movement_speed = speed
		#gets the players coordinates and moves the enemy in its direction
		direction = (player.position - position).normalized()
	position += direction * movement_speed * delta
	
	
# if the enemy leaves the screen they die
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

# if the enemy  gets hit by a bullet they despawn and 100
# points to the score board 
func _on_hitbox_area_entered(area):
	health = health - GlobalStats.getAcornDamage()
	
	$damage_indicator.text = "-100"
	$damage_indicator.show()
	$damage_indicator_timer.start();
	
	if(health <= 0):
		main.addToScore(100)
		queue_free()


func _on_damage_indicator_timer_timeout():
	$damage_indicator.hide()


func _on_hurtbox_area_entered(area):
	if (not cooldown):
		attacking = true
		print('attacking')
