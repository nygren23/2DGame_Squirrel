extends Node2D

################################################################

#player/game stats
var maxHealth = 4
var nuxMaxHealth = 999
var numAcorns = 20
var nuxNumAcorns = 999
var speed = 400.0
var acornDamage = 100
var score = 0
var roundNumber = 0

#timers
var roundTimer = 20
var mobTimer = 4
var acornTimer = 1

#checks if nux mode should be active (999 health/acorns)
var nuxModeFlag = false

#upgrade levels - tied to upgrade cost (increases incrementally)
var speedLevel = 1
var healthLevel = 1
var damageLevel = 1

################################################################

# Called when the node enters the scene tree for the first time.
func _ready():
	print(maxHealth)
	
#getters/setters	
func getSpeedLevel(): 
	return speedLevel
	
func setSpeedLevel(newSpeedLevel):
	speedLevel = newSpeedLevel
	
func getHealthLevel():	
	return healthLevel
	
func setHealthLevel(newHealthLevel):
	healthLevel = newHealthLevel
	
func getDamageLevel(): 
	return damageLevel
	
func setDamageLevel(newDamageLevel):
	damageLevel = newDamageLevel
	
func getAcornTimer():
	return acornTimer
	
func getNuxMaxHealth():
	return nuxMaxHealth
	
func getNuxNumAcorns():
	return nuxNumAcorns

func setMaxHealth(newMaxHealth):
	maxHealth = newMaxHealth

func getMaxHealth():
	return maxHealth

func setSpeed(new_speed):
	speed = new_speed

func getSpeed():
	return speed

func getAcornDamage():
	return acornDamage

func setAcornDamage(newAcornDamage):
	acornDamage = newAcornDamage

func getRoundNumber():
	return roundNumber

func setRoundNumber(newRoundNumber):
	roundNumber = newRoundNumber
	
func getRoundTimer():
	return roundTimer

func setRountTimer(newRoundTimer):
	roundTimer = newRoundTimer

func getMobTimer():
	return mobTimer

func setMobTimer(newMobTimer):
	mobTimer = newMobTimer

func getScore():
	return score

func setScore(newScore):
	score = newScore

func getNumAcorns():
	return numAcorns
func setNumAcorns(newNumAcorns):
	numAcorns = newNumAcorns
