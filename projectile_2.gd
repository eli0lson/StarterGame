extends CharacterBody2D

const SPEED = 600.0
var DMG = 5

var shot_vector = Vector2.ZERO

func _ready():
	print(Stats.stats)
	if "projectile_image" in Stats.stats:
		$AnimatedSprite2D.animation = Stats.stats["projectile_image"]
	if "damage" in Stats.stats:
		DMG = Stats.stats["damage"]
	shot_vector = Vector2.ZERO
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(shot_vector * delta)
	if collision:
		#var collider = collision.get_collider().get_class()
		#print(collider.class_name())
		if collision.get_collider().has_method("ouch"):
			collision.get_collider().ouch(DMG)
		despawn()
		
		
func fire(input, character_velocity, delta):
	show()
	$AnimatedSprite2D.play()
	
	if input + character_velocity != Vector2.ZERO:
		input += (character_velocity.normalized() * .2)
	
	shot_vector = velocity.move_toward(input * SPEED, delta * 100000)
	#velocity = velocity.move_toward(shot_vector, delta)
	#print(velocity)
	#move_and_slide()

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	despawn()

func despawn():
	$AnimatedSprite2D.stop()
	hide()
	queue_free()

func set_sprite(path):
	$AnimatedSprite2D.animation = path
