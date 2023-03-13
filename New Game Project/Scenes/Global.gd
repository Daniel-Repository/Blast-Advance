extends Node


signal gameOver
signal meteorDestroyed(meteorPosition)
var playerScore


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerScore = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
