extends Node2D
onready var game_over: AudioStreamPlayer = $GameOver
onready var sound_meteor_destoryed: AudioStreamPlayer = $SoundMeteorDestoryed
onready var player: RigidBody2D = $Player

var meteor1 = preload("res://Scenes/Meteor1.tscn")
var meteor2 = preload("res://Scenes/Meteor2.tscn")
var meteor3 = preload("res://Scenes/Meteor3.tscn")

var particleMeteorDestroy = preload("res://Particles/particleDestroyMeteor.tscn")

onready var lblScore = preload("res://Scenes/lblScore.tscn")
onready var lbl_player_score: Label = $UI/ScoreContainer/lblPlayerScore
onready var progress_upgrade: ProgressBar = $UI/ScoreContainer/progressUpgrade
onready var black_fade: ColorRect = $UI/BlackFade
onready var upgrade_container: CenterContainer = $UI/UpgradeContainer
onready var anim_upgrade_ui: AnimationPlayer = $UI/UpgradeContainer/VBoxContainer/animUpgradeUI
onready var sound_upgrade: AudioStreamPlayer = $UI/UpgradeContainer/SoundUpgrade
onready var lbl_new_upgrade_text: Label = $UI/UpgradeContainer/VBoxContainer/lblNewUpgradeText
onready var upgrade_timer: Timer = $UI/upgradeTimer
onready var lbl_new_upgrade_title: Label = $UI/UpgradeContainer/VBoxContainer/lblNewUpgradeTitle
onready var game_over_container: CenterContainer = $UI/GameOverContainer
onready var lbl_score: Label = $UI/GameOverContainer/vboxGameoverContent/lblScore


onready var scores: CanvasLayer = $Scores
onready var particles: Node2D = $Particles

onready var camera_2d: Camera2D = $Camera2D
onready var spawn_timer: Timer = $SpawnTimer

onready var anim_controls: AnimationPlayer = $UI/ControlsContainer/animControls

var arrMeteors = [meteor1, meteor2, meteor3]


var currentStage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("gameOver", self, "gameOver")
	Global.connect("meteorDestroyed", self, "meteorDestroyed")
	Global.connect("gameStart",self,"startSpawning")
	currentStage = 1

func _on_SpawnTimer_timeout() -> void:
	var m = arrMeteors[randi()%3].instance()
	m.start()
	get_parent().add_child(m)

func gameOver():
	camera_2d.add_stress(20)
	sound_meteor_destoryed.play()
	game_over.play()
	black_fade.visible = true
	lbl_score.text = "SCORE: " + str(Global.playerScore)
	game_over_container.visible = true
	Global.gameIsOver = true
	upgrade_timer.start()

func meteorDestroyed(meteorPosition, meteorName):
	var newScore = lblScore.instance()
	var newMeteorParticle = particleMeteorDestroy.instance()
	var meteorScore
	
	if "Meteor1" in meteorName:
		meteorScore = 5
	elif "Meteor2" in meteorName:
		meteorScore = 10
	elif "Meteor3" in meteorName:
		meteorScore = 15
	
	newScore.text = "+" + str(meteorScore)
	scores.add_child(newScore)
	newScore.rect_position.x = meteorPosition.x - 19
	newScore.rect_position.y = meteorPosition.y - 20
	Global.playerScore += meteorScore
	lbl_player_score.text = "Score: " + str(Global.playerScore)
	
	progress_upgrade.value += meteorScore
	
	particles.add_child(newMeteorParticle)
	newMeteorParticle.position.x = meteorPosition.x
	newMeteorParticle.position.y = meteorPosition.y
	
	camera_2d.add_stress(20)
	sound_meteor_destoryed.play()

func nextStage():
	currentStage += 1
	if currentStage == 6:
		lbl_new_upgrade_title.text = "Last Upgrade!"
		progress_upgrade.value = progress_upgrade.max_value
	lbl_new_upgrade_text.text = Upgrades.getUpgradeText(currentStage)
	get_tree().paused = true
	black_fade.visible = true
	upgrade_container.visible = true
	anim_upgrade_ui.play("UpgradeUI")
	sound_upgrade.play()
	upgrade_timer.start()
	player.playerUpgrade(currentStage)
	
	var timeDecrease = (spawn_timer.wait_time / 100) * 25
	spawn_timer.wait_time -= timeDecrease

func _on_progressUpgrade_value_changed(value: float) -> void:
	if value >= progress_upgrade.max_value && currentStage <= 6:
		nextStage()
		progress_upgrade.value = 0
		progress_upgrade.max_value += 40

func startSpawning():
	spawn_timer.start()
	anim_controls.play("ControlsFadeOut")
