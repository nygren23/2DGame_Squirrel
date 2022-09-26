extends Node2D


var maxHealth = 4
var numAcorns = 20
var speed = 400.0
var acornDamage = 100
var roundNumber = 0
var roundTimer = 20
var mobTimer = 3
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print(maxHealth)

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
