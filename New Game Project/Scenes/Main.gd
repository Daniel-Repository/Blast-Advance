extends Node2D
onready var game_over: AudioStreamPlayer = $GameOver


var meteor = preload("res://Scenes/Meteor1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("gameOver", self, "gameOver")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_SpawnTimer_timeout() -> void:
	var m = meteor.instance()
	m.start()
	get_parent().add_child(m)

func gameOver():
	game_over.play()
