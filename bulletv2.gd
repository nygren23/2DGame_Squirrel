#This is a second bullet script. It was a another attempt at
#making a bullet but it did not work. This script is never used
extends Area2D

var xdire = 0
var ydire = 0 
var speed = 900
var direction = Vector2.ZERO
var shot = false


func _process(delta):
	if (!shot):
		var target = get_viewport().get_mouse_position()
		xdire = target.x-position.x 
		ydire = target.y-position.y
	shot = true
	
	direction.x += xdire
	direction.y += ydire
	if direction.length() > 1:
		direction = direction.normalized()
	position += direction * speed * delta
