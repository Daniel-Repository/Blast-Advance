extends RigidBody2D

export var shootPower = 120
export var rotateSpeed = 8
var velocity = Vector2.ZERO

var bullet = preload("res://Scenes/Bullet.tscn")
var bulletTwo = preload("res://Scenes/Bullet2.tscn")
var bulletThree = preload("res://Scenes/Bullet3.tscn")

onready var sound_shoot: AudioStreamPlayer = $SoundShoot
onready var camera_2d: Camera2D = $"../Camera2D"
onready var anim_player: AnimationPlayer = $animPlayer

var deadzone = 0.5

signal reloading

var currentBullet
var spreadUnlocked
var circleshotUnlocked 

var bulletCount
var reloadCount
var reloading
var bulletSpeed
var gameStart

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentBullet = bullet
	spreadUnlocked = false
	circleshotUnlocked = false
	bulletCount = 0
	reloadCount = 20
	bulletSpeed = 500
	reloading = false
	gameStart = false

func _physics_process(delta: float) -> void:
	
	#var look_vector = Vector2(0,0)
	#look_vector.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
	#look_vector.y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
	#look_at(look_vector)
	
	#look_at(get_global_mouse_position())
	get_input()

func get_input():
	if Input.is_action_just_pressed("ui_accept") && reloading == false:
		#apply_central_impulse(-position.direction_to(get_global_mouse_position()) * shootPower)
		apply_central_impulse(Vector2(-cos(rotation),-sin(rotation)) * shootPower)
		
		if circleshotUnlocked == true && bulletCount == 19:
			var b1 = currentBullet.instance()
			var b2 = currentBullet.instance()
			var b3 = currentBullet.instance()
			var b4 = currentBullet.instance()
			var b5 = currentBullet.instance()
			var b6 = currentBullet.instance()
			
			b1.start(bulletSpeed,transform.origin,rotation)
			b2.start(bulletSpeed,transform.origin,rotation + 1)
			b3.start(bulletSpeed,transform.origin,rotation + 2)
			b4.start(bulletSpeed,transform.origin,rotation + 3)
			b5.start(bulletSpeed,transform.origin,rotation + 4)
			b6.start(bulletSpeed,transform.origin,rotation + 5)
			
			get_parent().add_child(b1)
			get_parent().add_child(b2)
			get_parent().add_child(b3)
			get_parent().add_child(b4)
			get_parent().add_child(b5)
			get_parent().add_child(b6)
			
		elif spreadUnlocked == true && bulletCount == 9:
			bulletCount = 0
			var b1 = currentBullet.instance()
			var b2 = currentBullet.instance()
			var b3 = currentBullet.instance()
			
			b1.start(bulletSpeed,transform.origin,rotation + 18)
			b2.start(bulletSpeed,transform.origin,rotation)
			b3.start(bulletSpeed,transform.origin,rotation - 18)
			
			get_parent().add_child(b1)
			get_parent().add_child(b2)
			get_parent().add_child(b3)
		else:
			bulletCount += 1
			var b = currentBullet.instance()
			b.start(bulletSpeed,transform.origin,rotation)
			get_parent().add_child(b)
		
		if gameStart == false:
			gameStart = true
			Global.emit_signal("gameStart")
		
		#reloadCount -= 1
		
		#if reloadCount == 0:
		#	reloading = true
		#	emit_signal("reloading")
		
		sound_shoot.play()
		camera_2d.add_stress(0.2)
		anim_player.stop(true)
		anim_player.play("PlayerShoot")
	
	if Input.is_action_pressed("ui_left"):
		angular_velocity = -1 * rotateSpeed
	elif Input.is_action_pressed("ui_right"):
		angular_velocity = 1 * rotateSpeed
	else:
		angular_velocity = 0

func playerUpgrade(currentStage):
	match(currentStage):
		2:
			currentBullet = bulletTwo #10% bigger bullet
		3:
			spreadUnlocked = true #Three bullets spread in cone every 10th shot
			bulletCount = 0
		4:
			bulletSpeed = 600
		5:
			currentBullet = bulletThree #10% bigger bullet
		6:
			circleshotUnlocked = true
			bulletCount = 0
		7:
			pass
