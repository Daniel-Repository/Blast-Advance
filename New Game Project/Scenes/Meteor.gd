extends RigidBody2D

export var speed = 300
var rotationSpeed = 60
var velocity = Vector2()
var sideOptions
var dirtocent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	look_at(Vector2(612,300))
	var rand = rand_range(0.5,3)

func start():
	randomize()
	var top = Vector2(rand_range(0, 1024), -150)
	var bottom = Vector2(rand_range(0, 1024), 750)
	var left = Vector2(-150, rand_range(0, 600))
	var right = Vector2(1200, rand_range(0, 600))
	
	sideOptions = [top, bottom, left, right]
	position = sideOptions[rand_range(0,3)]
	dirtocent = position.direction_to(Vector2(rand_range(200,900),rand_range(200,400)))
	apply_central_impulse(dirtocent * rand_range(40,100))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass





func _on_Area2D_body_entered(body: Node) -> void:
	
	if body.name == "Player":
		body.queue_free()
	else:
		queue_free()
		body.queue_free()
