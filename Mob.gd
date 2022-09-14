extends RigidBody2D

signal dies

export var min_speed = 400
export var max_speed = 500
export var speed = 320


onready var player = get_node("/root/Main/Player")
onready var main = get_node("/root/Main")
func _ready():
	$AnimatedSprite.play()
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


func _process(delta):
	if(main.getSafe()):
		queue_free()
	var direction = (player.position - position).normalized()
	position += direction * speed * delta
	
	



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_hitbox_area_entered(area):
	main.addToScore(100)
	queue_free()
	
