#main script that puts all the enemies and players together
extends Node

export (PackedScene) var mob_scene
export (PackedScene) var bullet
export (PackedScene) var acorn_scene

var roundnumber = 1
var newGame = true #If the game has just started. It is used to 
# differentiate whether it is the beggining of a round or game
var safe = true # determines whether enemies should be spawning or not
var enemy_spawn_array # array of all the spawn points for enemies 
var acorn_spawn_array
var score = 0 # current score 

#puts the spawn points in an array. 
func _ready():
	
	randomize()
	enemy_spawn_array = [$enemySpawnPoint0,$enemySpawnPoint1,$enemySpawnPoint2,$enemySpawnPoint3]
	acorn_spawn_array = [$asp1,$asp2,$asp3,$asp4,$asp5]
	
# starts a new round or game. 
func new_game():
	#if it is a new game then it sets the score is 0.
	if(newGame):
		score = 0
		newGame = false
		$HUD.update_score(score)
		#GlobalStats.setNumAcorns(20)
	
	$Player.setAcorns(GlobalStats.getNumAcorns())
	$Player.setSpeed(GlobalStats.getSpeed());
	$Player.setMaxHealth(GlobalStats.getSpeed());
	$Player.setHealth(GlobalStats.getMaxHealth())
	
	if(GlobalStats.getRoundNumber()%3 == 0):
		GlobalStats.setRountTimer(GlobalStats.getRoundTimer()+20)
		GlobalStats.setMobTimer(GlobalStats.getMobTimer() *0.5)
	
	$endOfMatchTimer.set_wait_time(GlobalStats.getRoundTimer())
	$MobTimer.set_wait_time(GlobalStats.getMobTimer())
	
	#$Player.setAcorns($Player.getMaxAcorns())
	
	$Player.start($StartPosition.position) #spawns the player
	$StartTimer.start()
	$Music.play()
	
	$HUD.show_message("Get ready...")
	safe  = false 
	yield($StartTimer, "timeout")
	$ScoreTimer.start()
#can comment out to debug without enemies
	$MobTimer.start()
	$AcornTimer.start()
	$endOfMatchTimer.start()
	
func new_game_cheated():
	$Player.setAcorns(999)
	$Player.setHealth(999)
	new_game()
	
	
func take_damage():
	game_over()
	
#activates when player runs out of health 	
func game_over():
	safe = true 
	$endOfMatchTimer.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$AcornTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	$Player.setGameStart()
	newGame = true
	$Player.setHealth($Player.getMaxHealth())
	$Player.setAcorns($Player.getMaxAcorns())
	#get_tree().change_scene("res://StartMenu.tscn")
	

#summons an enemy in one of three random locations 
func _on_MobTimer_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(0,3)
	
	var mob = mob_scene.instance()
	get_parent().add_child(mob)
	mob.position = enemy_spawn_array[my_random_number].global_position
	
#spawns acorns on Timer - only spawns from one position for now	
func _on_AcornTimer_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(0,5)
	
	var acorn = acorn_scene.instance()
	get_parent().add_child(acorn)
	acorn.position = acorn_spawn_array[my_random_number].global_position


#adds ten to the score for every second the player lives 
func _on_ScoreTimer_timeout():
	GlobalStats.setScore(GlobalStats.getScore()+20)
	$HUD.update_score(GlobalStats.getScore())


#plays when the match is over. 
func _on_endOfMatchTimer_timeout():
	safe = true
	$endOfMatchTimer.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$AcornTimer.stop()
	$HUD.show_round_over()
	$Music.stop()
	GlobalStats.setNumAcorns($Player.getAcorns())
	#$Player.setHealth($Player.getMaxHealth())
	#$Player.setAcorns($Player.getMaxAcorns())
	
	#if(roundnumber%3 == 0):
	#	$endOfMatchTimer.set_wait_time($endOfMatchTimer.get_wait_time() + 20)
	#	$MobTimer.set_wait_time($MobTimer.get_wait_time() * 0.5)

	#roundnumber +=1
	$Player.setGameStart()
	
#"main" function - runs every frame
func _process(delta):
	if $Player.game_start:
		$HUD.show_all()
		$HUD.update_time(int($endOfMatchTimer.time_left))
		$HUD.update_acorns($Player.acorns)
		$HUD.update_health($Player.health)
	else:
		$HUD.hide_all()
		if Input.is_action_just_pressed("cheat_code"):			
			$HUD/NuxMode.show() if !$HUD/NuxMode.visible else $HUD/NuxMode.hide()
		
func getSafe():
	return safe

func addToScore(bonus):
	GlobalStats.setScore(GlobalStats.getScore() + 100)
	$HUD.update_score(GlobalStats.getScore())

func _on_UpgradeButtonTemp_pressed():
	get_tree().change_scene("res://Main")
	#get_tree().change_scene("/root/Main/UpgradeScreen.tscn")
	
