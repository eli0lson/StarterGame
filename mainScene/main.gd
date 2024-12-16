extends Node

var screen_size
@export var mob_scene: PackedScene
@export var projectile2_scene: PackedScene
@export var item_scene: PackedScene
var score

var can_shoot = true
var game_is_over = true
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size
	
	$Ceiling/CollisionShape2D.set_position_and_rotation(Vector2.ZERO, PI)
	$Floor/CollisionShape2D.set_position_and_rotation(Vector2(0, screen_size.y), 0)
	$LeftWall/CollisionShape2D.set_position_and_rotation(Vector2.ZERO, PI / 2)
	$RightWall/CollisionShape2D.set_position_and_rotation(Vector2(screen_size.x, 0), -(PI / 2))
	
	$PhysicsPlayer.start($StartPosition.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var projectileInput = Input.get_vector("shoot_left", "shoot_right", "shoot_up", "shoot_down")
	if projectileInput && can_shoot && !game_is_over:
		handle_fire(projectileInput, delta)

func handle_fire(input, delta):
	var projectile = projectile2_scene.instantiate()
	#projectile.set_sprite(Stats.projectile_image)
	
	# animation is facing wrong way so flip to begin with
	var projectile_rotation = PI
	if input.x != 0:
		#projectile.flip_v = false
		projectile_rotation = PI / 2 if input.x < 0 else -PI / 2
		
	if input.y > 0:
		projectile_rotation = 0
	
	#projectile.angular_velocity = projectioleddddddddddddddddddd
	
	projectile.position = $PhysicsPlayer.position
	projectile.rotation = projectile_rotation
	add_child(projectile)
	
	var character_velocity = $PhysicsPlayer.velocity
	#if character_velocity + input == Vector2.ZERO:
		#character_velocity = Vector2.ZERO
	projectile.fire(input, character_velocity, delta)
	can_shoot = false
	$ShotTimer.start()

func game_over():
	#$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Mob.game_over()
	game_is_over = true

func new_game():
	Score.score = 0
	$PhysicsPlayer.start($StartPosition.position)
	#$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(Score.score)
	$HUD.show_message("Get Ready")

func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	mob.show()
	
	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position
	
	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func add_score() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	#$ScoreTimer.start()
	$MobTimer.start()
	game_is_over = false
	$ItemTimer.start()

func _on_shot_timer_timeout():
	if "fire_rate" in Stats.stats:
		if Stats.stats["fire_rate"] != $ShotTimer.wait_time:
			$ShotTimer.wait_time = Stats.stats["fire_rate"]
	can_shoot = true


func _on_item_timer_timeout() -> void:
	var item = item_scene.instantiate()
	add_child(item)
	
	
