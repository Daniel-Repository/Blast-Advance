extends Node2D


var meteor = preload("res://Scenes/Meteor1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_SpawnTimer_timeout() -> void:
	var m = meteor.instance()
	m.start()
	get_parent().add_child(m)
	
