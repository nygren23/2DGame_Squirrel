#enemy class So far there is only one time and they all do the same thing 
# they are set to follow the player
extends RigidBody2D

signal dies


export var min_speed = 400 # min speed not used 
export var max_speed = 500 # max speed not sued 
export var speed = 200 # default speed is used for all enemies that spawn
onready var player = get_node("/root/Main/Player")
onready var main = get_node("/root/Main")

#chooses from an array of animation to used. So for there is only one animation.
func _ready():
	$AnimatedSprite.play()
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

#moves the enemy and despawns them
func _process(delta):
	#if the game or round ends then the enemy despawns
	if(main.getSafe()):
		queue_free()
	
	if (player.position.x<position.x):
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	
	
	#gets the players coordinates and moves the enemy in its direction
	var direction = (player.position - position).normalized()
	position += direction * speed * delta
	
	
# if the enemy leaves the screen they die
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

# if the enemy  gets hit by a bullet they despawn and 100
# points to the score board 
func _on_hitbox_area_entered(area):
	main.addToScore(100)
	queue_free()
	
