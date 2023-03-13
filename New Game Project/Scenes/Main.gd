extends Node2D
onready var game_over: AudioStreamPlayer = $GameOver
onready var sound_meteor_destoryed: AudioStreamPlayer = $SoundMeteorDestoryed


var meteor1 = preload("res://Scenes/Meteor1.tscn")
var meteor2 = preload("res://Scenes/Meteor2.tscn")
var meteor3 = preload("res://Scenes/Meteor3.tscn")

var particleMeteorDestroy = preload("res://Particles/particleDestroyMeteor.tscn")

onready var lblScore = preload("res://Scenes/lblScore.tscn")
onready var lbl_player_score: Label = $UI/lblPlayerScore

onready var scores: CanvasLayer = $Scores
onready var particles: Node2D = $Particles

onready var camera_2d: Camera2D = $Camera2D

var arrMeteors = [meteor1, meteor2, meteor3]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("gameOver", self, "gameOver")
	Global.connect("meteorDestroyed", self, "meteorDestroyed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_SpawnTimer_timeout() -> void:
	var m = arrMeteors[randi()%3].instance()
	m.start()
	get_parent().add_child(m)

func gameOver():
	camera_2d.add_stress(20)
	sound_meteor_destoryed.play()
	game_over.play()

func meteorDestroyed(meteorPosition, meteorName):
	var newScore = lblScore.instance()
	var newMeteorParticle = particleMeteorDestroy.instance()
	var meteorScore
	
	if "Meteor1" in meteorName:
		meteorScore = 5
	elif "Meteor2" in meteorName:
		meteorScore = 5
	elif "Meteor3" in meteorName:
		meteorScore = 10
	
	newScore.text = "+" + str(meteorScore)
	scores.add_child(newScore)
	newScore.rect_position.x = meteorPosition.x - 20
	newScore.rect_position.y = meteorPosition.y - 20
	Global.playerScore += meteorScore
	lbl_player_score.text = "Score: " + str(Global.playerScore)
	
	particles.add_child(newMeteorParticle)
	newMeteorParticle.position.x = meteorPosition.x
	newMeteorParticle.position.y = meteorPosition.y
	
	camera_2d.add_stress(20)
	sound_meteor_destoryed.play()
	print(Global.playerScore)
