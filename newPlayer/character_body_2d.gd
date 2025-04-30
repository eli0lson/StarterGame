extends CharacterBody2D

signal hit
signal fire
signal outfit_change

#@export var projectile_scene: PackedScene
#@export var projectile2_scene: PackedScene

# what if he's like a lil duck
# and he gets lil hats that can do cool stuff
# OR a hermit crab
# nope he's a cowboy

const SPEED = 325.0
const ACCEL = 2000.0
const FRICTION = 1000.0

var screen_size
var direction = " down"
var movement_vector = Vector2.ZERO
var cur_accessories = {}

func handle_movement(input: Vector2, firing_input: Vector2, delta):
	if input != Vector2.ZERO or firing_input != Vector2.ZERO:
		var animation_input = input
		velocity = velocity.move_toward(input * SPEED, delta * ACCEL)
		if input == Vector2.ZERO:
			$body.stop()
		else:
			$body.play()
		if firing_input != Vector2.ZERO:
			animation_input = firing_input
		
		var new_direction = direction
		if animation_input.y != 0:
			new_direction = " down" if animation_input.y > 0 else " up"
			$body.speed_scale = -1 if animation_input.y != input.y else 1
		else:
			new_direction = " right" if animation_input.x > 0 else " left"
			$body.speed_scale = -1 if animation_input.x != input.x else 1
		
		if new_direction != direction or velocity != movement_vector or cur_accessories != Stats.stats["accessories"]:
			direction = new_direction
			movement_vector = velocity
			update_outfit()
	
			
			#rotation = -PI / 4 if input.x < 0 else PI / 4
			
		#$CollisionShape2D.rotation = rotation
		
		#if input.y != 0:
			#rotation = 0
			#$Body.flip_v = input.y > 0
		#$CollisionShape2D.flip_v = input.y > 0
		
		#$Body.rotation = rotation
		#$CollisionShape2D.rotation = rotation
		
		
		
	else:
		direction = " down"
		update_outfit()

		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
		$body.stop()
		
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
	var fire_input = Input.get_vector("shoot_left", "shoot_right", "shoot_up", "shoot_down")
	
	if fire_input:
		$weapon.play()
	else:
		$weapon.stop()
	
	var playerVelocity = handle_movement(input, fire_input, delta)
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
		update_outfit()
	

func start(position: Vector2):
	show()
	screen_size = get_viewport_rect().size
	velocity = Vector2.ZERO
	global_position = position
	#global_position = position.clamp(Vector2.ZERO, screen_size)
	$CollisionShape2D.disabled = false

func ouch():
	pass
	#hide()
	#hit.emit()
	#$CollisionShape2D.set_deferred("disabled", true)
	
func fire_weapon():
	$weapon.play()
	
func update_outfit():
	cur_accessories = Stats.stats["accessories"]
	$body.animation = 'naked cowboy' + direction
	for accessory in cur_accessories:
		var new_direction = direction
		var sprite = get_node(accessory)
		if cur_accessories[accessory] == "none":
			new_direction = ""
			
		sprite.animation = cur_accessories[accessory] + new_direction
		#$Weapon.animation = accessories["weapon"] + direction
		#$Hat.animation = accessories["hat"] + direction
		#$Clothes.animation = accessories["clothes"] + direction
