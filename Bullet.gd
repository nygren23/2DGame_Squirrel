extends Area2D
# stop here 
var xdire = 0
var ydire = 0 
var speed = 900
var direction = Vector2.ZERO
var shot = false

func _ready():
	look_at(get_global_mouse_position())

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
	
	
	
	




func _on_Bullet_area_entered(area):
	print("enemy hit")
	queue_free()

