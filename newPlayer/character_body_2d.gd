extends CharacterBody2D

signal hit

#@export var projectile_scene: PackedScene
#@export var projectile2_scene: PackedScene

# what if he's like a lil duck
# and he gets lil hats that can do cool stuff
# OR a hermit crab

const SPEED = 250.0
const ACCEL = 2000.0
const FRICTION = 800.0

var screen_size

func handle_movement(input: Vector2, delta):
	if input:
		velocity = velocity.move_toward(input * SPEED, delta * ACCEL)
		if input.x != 0:
			$AnimatedSprite2D.flip_h = input.x < 0
			#rotation = -PI / 4 if input.x < 0 else PI / 4
			
		#$CollisionShape2D.rotation = rotation
		
		#if input.y != 0:
			#rotation = 0
			#$AnimatedSprite2D.flip_v = input.y > 0
		#$CollisionShape2D.flip_v = input.y > 0
		
		#$AnimatedSprite2D.rotation = rotation
		#$CollisionShape2D.rotation = rotation
		
		$AnimatedSprite2D.play()
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
		$AnimatedSprite2D.stop()
		
	return velocity
	#
#func handle_fire(input, delta):
	#var projectile = projectile2_scene.instantiate()
	#
	#var projectile_rotation = 0
	#if input.x != 0:
		##projectile.flip_v = false
		#projectile_rotation = -PI / 4 if input.x < 0 else PI / 4
		#
	#if input.y > 0:
		#projectile_rotation = PI / 2
	#
	##projectile.angular_velocity = projectioleddddddddddddddddddd
	#
	#add_child(projectile)
	#projectile.fire(input, delta)
	#can_shoot = false
	#$ShotTimer.start()
		
func _physics_process(delta: float) -> void:
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var playerVelocity = handle_movement(input, delta)
	#if (projectileInput && can_shoot):
		#handle_fire(projectileInput, delta)
	
	playerVelocity.limit_length(SPEED)
	
	var collision = move_and_collide(playerVelocity * delta)
	if collision:
		handle_collision(collision, playerVelocity * delta)
			
func handle_collision(collision, go_to):
	if collision.get_collider().get_class() == "RigidBody2D":
		ouch()
	else:
		move_and_slide()
	

func start(position: Vector2):
	show()
	screen_size = get_viewport_rect().size
	velocity = Vector2.ZERO
	global_position = position
	#global_position = position.clamp(Vector2.ZERO, screen_size)
	$CollisionShape2D.disabled = false

func ouch():
	#pass
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
