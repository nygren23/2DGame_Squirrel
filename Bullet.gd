#Bullet script. The bullet can be fired by the player when they
#click the screen. The bullet is shot where the mouse click
# takes place
extends Area2D
 
var xdire = 0 #this is x direction that the bullet goes in
var ydire = 0 #this is y direction that the bullet goes in
var speed = 900 #speed of the bullet
var direction = Vector2.ZERO # direction of the bullt. set to 0 before the click
var shot = false #tell whether the bullet has been shot. 


	
#This method makes the bullet go forward and sets it direction 
func _process(delta):
	#this if statement sets the direction of the bullet.
	#it is only set once
	if (!shot):
		look_at(get_global_mouse_position())
		var target = get_viewport().get_mouse_position()
		xdire = target.x-position.x 
		ydire = target.y-position.y
	
	shot = true
	
	#The rest of the method moves the bullet forward
	direction.x += xdire
	direction.y += ydire
	if direction.length() > 1:
		direction = direction.normalized()
	position += direction * speed * delta
	
	
	
	
# this destroys the bullet when it hits an enemy
func _on_Bullet_area_entered(area):
	print("enemy hit")
	queue_free()

