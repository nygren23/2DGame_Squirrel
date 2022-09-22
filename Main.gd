#main script that puts all the enemies and players together
extends Node

export (PackedScene) var mob_scene
export (PackedScene) var bullet

var roundnumber = 1
var newGame = true #If the game has just started. It is used to 
# differentiate whether it is the beggining of a round or game
var safe = true # determines whether enemies should be spawning or not
var spawn_array # array of all the spawn points for enemies 
var score = 0 # current score 

#puts the spawn points in an array. 
func _ready():
	randomize()
	spawn_array = [$enemySpawnPoint0,$enemySpawnPoint1,$enemySpawnPoint2,$enemySpawnPoint3]
	
	
# starts a new round or game. 
func new_game():
	#if it is a new game then it sets the score is 0.
	if(newGame):
		score = 0
		newGame = false
		$HUD.update_score(score)
		
	$Player.start($StartPosition.position)#spawns the player
	$StartTimer.start()
	$Music.play()
	
	$HUD.show_message("Get ready...")
	safe  = false 
	yield($StartTimer, "timeout")
	$ScoreTimer.start()
	$MobTimer.start()
	$endOfMatchTimer.start()
	
#activates when player runs out of health 	
func game_over():
	safe = true 
	$endOfMatchTimer.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

	$Player.setGameStart()
	newGame = true

#summons an enemy in one of three random locations 
func _on_MobTimer_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(0,3)
	
	var mob = mob_scene.instance()
	get_parent().add_child(mob)
	mob.position = spawn_array[my_random_number].global_position

#adds one to the score for every second the player lives 
func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

#plays when the match is over. 
func _on_endOfMatchTimer_timeout():
	safe = true
	$endOfMatchTimer.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_round_over()
	$Music.stop()
	
	if(roundnumber%3 == 0):
		$endOfMatchTimer.set_wait_time($endOfMatchTimer.get_wait_time() + 20)
		if(roundnumber == 3):
			$MobTimer.set_wait_time($MobTimer.get_wait_time() * 0.5)

	roundnumber +=1
	$Player.setGameStart()
	

func getSafe():
	return safe

func addToScore(bonus):
	score += bonus
	$HUD.update_score(score)
