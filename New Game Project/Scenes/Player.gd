extends RigidBody2D

export var shootPower = 100
export var rotateSpeed = 8
var velocity = Vector2.ZERO
var bullet = preload("res://Scenes/Bullet.tscn")
onready var sound_shoot: AudioStreamPlayer = $SoundShoot
onready var camera_2d: Camera2D = $"../Camera2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	#look_at(get_global_mouse_position())
	get_input()

func get_input():
	if Input.is_action_just_pressed("ui_select"):
		#apply_central_impulse(-position.direction_to(get_global_mouse_position()) * shootPower)
		apply_central_impulse(Vector2(-cos(rotation),-sin(rotation)) * shootPower)
		var b = bullet.instance()
		b.start(transform.origin,rotation)
		get_parent().add_child(b)
		sound_shoot.play()
		camera_2d.add_stress(0.2)
	
	if Input.is_action_pressed("ui_left"):
		angular_velocity = -1 * rotateSpeed
	elif Input.is_action_pressed("ui_right"):
		angular_velocity = 1 * rotateSpeed
	else:
		angular_velocity = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
