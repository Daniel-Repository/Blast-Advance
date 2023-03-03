extends RigidBody2D

export var shoot_power = 100
var velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	get_input()

func get_input():
	if Input.is_action_just_pressed("ui_select"):
		apply_central_impulse(position.direction_to(get_global_mouse_position()) * shoot_power)
	#if Input.is_action_pressed("ui_up"):
	#	velocity += transform.x * move_speed
	#if Input.is_action_pressed("ui_down"):
	#	velocity -= transform.x * move_speed
	
	
	#velocity = velocity.normalized() * move_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
