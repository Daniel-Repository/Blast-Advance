extends RigidBody2D

export var shoot_power = 100
var velocity = Vector2.ZERO
var bullet = preload("res://Scenes/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	get_input()

func get_input():
	if Input.is_action_just_pressed("ui_select"):
		apply_central_impulse(position.direction_to(get_global_mouse_position()) * shoot_power)
		var b = bullet.instance()
		b.start(transform.origin,rotation)
		get_parent().add_child(b)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
