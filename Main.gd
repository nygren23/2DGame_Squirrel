extends Node

export (PackedScene) var mob_scene
export (PackedScene) var bullet

var safe = true;
var spawn_array
var score = 0

func _ready():
	randomize()
	spawn_array = [$enemySpawnPoint0,$enemySpawnPoint1,$enemySpawnPoint2,$enemySpawnPoint3]
	
	
	
func new_game():
	score = 0
	$HUD.update_score(score)
	
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition.position)
	
	
	$StartTimer.start()
	$Music.play()
	
	$HUD.show_message("Get ready...")
	safe  = false
	yield($StartTimer, "timeout")
	$ScoreTimer.start()
	$MobTimer.start()
	$endOfMatchTimer.start()
	
	
func game_over():
	safe = true
	$endOfMatchTimer.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

	$Player.setGameStart()

func _on_MobTimer_timeout():
#	var mob_spawn_location = $MobPath/MobSpawnLocation
#	mob_spawn_location.unit_offset = randf() 
#
#	var mob = mob_scene.instance()
#	add_child(mob)
#
#	mob.position = mob_spawn_location.position
#
#	var direction = mob_spawn_location.rotation + PI / 2
#	direction += rand_range(-PI / 4, PI / 4)
#	mob.rotation = direction
#
#	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
#	mob.linear_velocity = velocity.rotated(direction)
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(0,3)
	
	var mob = mob_scene.instance()
	get_parent().add_child(mob)
	mob.position = spawn_array[my_random_number].global_position


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_endOfMatchTimer_timeout():
	safe = true
	$endOfMatchTimer.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_round_over()
	$Music.stop()
	$Player.setGameStart()
	
	
func getSafe():
	return safe
