extends Area2D
signal hit

@export var speed = 0 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.!
@export var velocity = Vector2.ZERO

var MAX_SPEED = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
	elif Input.is_action_pressed("move_left"):
		velocity.x = -1
	else: 
		speed -= 5
		
	if Input.is_action_pressed("move_down"):
		velocity.y = 1
		velocity.x = 0
	if Input.is_action_pressed("move_up"):
		velocity.y = -1
		velocity.x = 0
		
	if (Input.is_anything_pressed()):
		if (speed < MAX_SPEED):
			speed += 20
	else:
		if (speed > 100):
			speed -= 5
		elif (speed > 0):
			speed -= 1
					
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed 
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = velocity.x < 0
		$AnimatedSprite2D.rotation = PI / 2
		#$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.rotation = 0
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false