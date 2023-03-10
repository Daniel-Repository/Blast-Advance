extends RigidBody2D

export var speed = 300
var rotationSpeed = 60
var velocity = Vector2()
var sideOptions
var dirtocent
onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	look_at(Vector2(612,300))
	var rand = rand_range(0.5,3)
	angular_velocity = rand_range(-0.6,0.6)

func start():
	randomize()
	var top = Vector2(rand_range(0, 1024), -150)
	var bottom = Vector2(rand_range(0, 1024), 750)
	var left = Vector2(-150, rand_range(0, 600))
	var right = Vector2(1200, rand_range(0, 600))
	
	sideOptions = [top, bottom, left, right]
	position = sideOptions[randi()%4]
	dirtocent = position.direction_to(Vector2(rand_range(200,900),rand_range(200,400)))
	apply_central_impulse(dirtocent * rand_range(30,120))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	checkLocation()

func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.queue_free()
		Global.emit_signal("gameOver")
	else:
		Global.emit_signal("meteorDestroyed")
		body.queue_free()
		queue_free()

func checkLocation():
	if position.x > 1300 or position.x < -400:
		print("GONE")
		queue_free()
	if position.y < -200 or position.y > 900:
		print("GONE")
		queue_free()


func _on_VisibilityNotifier2D_screen_entered() -> void:
	collision_shape_2d.disabled = false
	print("enabled")
