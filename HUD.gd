#This displays all the user interface. 

extends CanvasLayer

signal start_game
signal start_game_cheated
onready var player = get_node("/root/Main")

func _ready():
	$Upgrade.hide()

# Updates the score displayed at the top
func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)

func update_acorns(acorns):
	$Acorns.text = "Acorns: " + str(acorns)
	
func update_time(time):
	$TimerLabel.text = "Time Left: " + str(time)

func update_health(health):
	$HealthBarPlaceHolder.text = "Health: " + str(health)
	
#shows updates the message displayd in the center
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

#This happens when the game is over
func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Squirrel"
	$MessageLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$Start.show()

#this happpens when the round is over
func show_round_over():
	show_message("Round Over")
	$MessageLabel.text = "You have survived the round. "
	$MessageLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$Start.show()
	$Upgrade.show()

#This function starts the round
func _on_Start_pressed():
	$Start.hide()
	$Upgrade.hide()
	$NuxMode.hide()
	GlobalStats.setRoundNumber(GlobalStats.getRoundNumber()+1)
	$Round_Number.text = (str("Round: ", GlobalStats.getRoundNumber()))
	$Round_Number.show()
	emit_signal("start_game")
	

#This will hide the message displayed at the center. 
func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_NuxMode_pressed():
	$NuxMode.hide()
	$Start.hide()
	GlobalStats.nuxModeFlag = true
	emit_signal("start_game")
	
func hide_all():
	$ScoreLabel.hide()
	$TimerLabel.hide()
	$HealthBarPlaceHolder.hide()
	$Acorns.hide()
	
func show_all():
	$ScoreLabel.show()
	$TimerLabel.show()
	$HealthBarPlaceHolder.show()
	$Acorns.show()
	


func _on_Upgrade_pressed():
	get_tree().change_scene("res://UpgradeScreen.tscn")
