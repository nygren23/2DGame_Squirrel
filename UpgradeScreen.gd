extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_node("/root/Main/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(player.getMaxHealth())
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_QuitButton_pressed():
	get_tree().quit()

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://StartMenu.tscn")

func _on_Help_pressed():
	get_tree().change_scene("res://ControlsPage.tscn")

func _on_ContinueButton_pressed():
	get_tree().change_scene("res://Main.tscn")
	



func _on_Speed_pressed():
	Player.setSpeed(900)
