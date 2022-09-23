#player class. The user controls it with the wasd keys and can shoot
extends Area2D

signal hit 

var game_start = false #if the game has started yet

var health = 4
var acorns = 5

export var speed = 400.0 #how fast the player moves
var screen_size = Vector2.ZERO #screen size. Its actual size is set later
var bulletPath = preload('res://Bullet.tscn')
var maxHealth = 4;

#before the game starts. Screen size is set and hides the player
func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var direction = Vector2.ZERO
	
	#shoots a bullet if the game has started
	if Input.is_action_just_pressed("click") and game_start:
		shoot()
	
	#moves the player left right down or up	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	
	#makes the speed consistent
	if direction.length() > 0:
		direction = direction.normalized()
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()	
		
	position += direction * speed * delta #moves the player
	
	#makes sure the player doesnt moved off he screen
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	#does not work yet because all the animation frames are the same
	#but it the future it should animate the player move.
	if direction.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_h = direction.x < 0
		$AnimatedSprite.flip_v = false
	#elif direction.y != 0:
	#	$AnimatedSprite.animation = "up"
	#	$AnimatedSprite.flip_v = direction.y > 0
	#	$AnimatedSprite.flip_h = false

#spawns the player
func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false
	setGameStart()
	
#detects when the player is hit by an enemy. 
#they die automatically 
func _on_Player_body_entered(body):

	#allowing health system - not one hit kill
	#hide()
	#$CollisionShape2D.set_deferred("disabled", true)
	#emit_signal("hit")
	#allowing health system - not one hit kill
	health -=1 
	if (health <= 0):
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		emit_signal("hit")
  
#shoots a bullet where ever the mouse is.
func shoot():
	if(acorns > 0):
		var bullet = bulletPath.instance()
		get_parent().add_child(bullet)
		bullet.position = $Position2D.global_position
		acorns -= 1
		
#sets when the game starts.
func setGameStart():
	if(game_start):
		game_start = false
	else:
		game_start = true
		
func setHealth(newHealth):
	health = newHealth

func setAcorns(newAcorns):
	acorns = newAcorns

func getMaxHealth():
	return maxHealth
	
	
