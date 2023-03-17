extends Node


signal gameOver
signal gameStart
signal meteorDestroyed(meteorPosition, meteorName)

var playerScore
var gameIsOver


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerScore = 0
	gameIsOver = false

func gameOver():
	playerScore = 0
	gameIsOver = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
