extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_node("/root/Main/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	$endofroundmusic.play()
	

#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$SpeedLabel.text = "Speed Level: " + str(GlobalStats.getSpeedLevel())
	$DamageLabel.text = "Damage Level: " + str(GlobalStats.getDamageLevel())
	$HealthLabel.text = "Health Level: " + str(GlobalStats.getHealthLevel())
	$AcornsLeft.text = "Acorns Left: " + str(GlobalStats.getNumAcorns())



func _on_QuitButton_pressed():
	get_tree().quit()

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://StartMenu.tscn")

func _on_Help_pressed():
	get_tree().change_scene("res://ControlsPage.tscn")

func _on_ContinueButton_pressed():
	get_tree().change_scene("res://Main.tscn")
	

func _on_Speed_pressed():
	if(GlobalStats.numAcorns >= GlobalStats.getSpeedLevel()):
		GlobalStats.setSpeed(GlobalStats.getSpeed() + 50)
		GlobalStats.setNumAcorns(GlobalStats.getNumAcorns() - GlobalStats.getSpeedLevel())
		GlobalStats.setSpeedLevel(GlobalStats.getSpeedLevel() + 1)
		print("upgraded Speed, now " + str(GlobalStats.getNumAcorns()) + " acorns left")
	else:
		print("Not Enough Acorns")

func _on_Health_pressed():
	if(GlobalStats.numAcorns >= GlobalStats.getHealthLevel()):
		GlobalStats.setMaxHealth(GlobalStats.getMaxHealth() + 1)
		GlobalStats.setNumAcorns(GlobalStats.getNumAcorns() - GlobalStats.getHealthLevel())
		GlobalStats.setHealthLevel(GlobalStats.getHealthLevel() + 1)
		print("upgraded Health, now " + str(GlobalStats.getNumAcorns()) + " acorns left")
	else:
		print("Not Enough Acorns")
		
func _on_Acorn_Damage_pressed():
	if(GlobalStats.numAcorns >= GlobalStats.getDamageLevel()):
		GlobalStats.setAcornDamage(GlobalStats.getAcornDamage() + 100)
		GlobalStats.setNumAcorns(GlobalStats.getNumAcorns() - GlobalStats.getDamageLevel())
		GlobalStats.setDamageLevel(GlobalStats.getDamageLevel() + 1)
		print("upgraded Damage, now " + str(GlobalStats.getNumAcorns()) + " acorns left")
	else:
		print("Not Enough Acorns")
