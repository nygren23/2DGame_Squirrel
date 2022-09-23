#This displays all the user interface. 

extends CanvasLayer

signal start_game
signal start_game_cheated
onready var player = get_node("/root/Main")

# Updates the score displayed at the top
func update_score(score):
	$ScoreLabel.text = str(score)

func update_acorns(acorns):
	$Acorns.text = "Acorns: " + str(acorns)
	
func update_time(time):
	$TimerLabel.text = str(time)

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

#This function starts the round
func _on_Start_pressed():
	$Start.hide()
	$NuxMode.hide()
	emit_signal("start_game")

#This will hide the message displayed at the center. 
func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_NuxMode_pressed():
	$NuxMode.hide()
	$Start.hide()
	emit_signal("start_game_cheated")
	
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
	
