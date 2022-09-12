extends CanvasLayer

signal start_game

onready var player = get_node("/root/Main")

func update_score(score):
	$ScoreLabel.text = str(score)
	
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Squirrel"
	$MessageLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$Button.show()

func show_round_over():
	show_message("Round Over")
	$MessageLabel.text = "You have survived the round. "
	$MessageLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$Button.show()


func _on_Button_pressed():
	$Button.hide()
	emit_signal("start_game")


func _on_MessageTimer_timeout():
	$MessageLabel.hide()
