extends RigidBody2D

@export var direction = 0
signal score
var health = 20

const shot_sounds = [
	"res://art/squishyShot.mp3",
	"res://art/shot1.mp3",
	"res://art/shot2.mp3",
	"res://art/shot3.mp3",
	"res://art/shot4.mp3"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.flip_h = linear_velocity.x > 0
	$AnimatedSprite2D.play("frog")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	hide()
	queue_free()
	
func game_over():
	hide()
	
func play_sound():
	var sound = shot_sounds[randi_range(0, shot_sounds.size() - 1)]
	MobDeathSound.stream = load(sound)
	#print(MobDeathSound.playing)
	
	MobDeathSound.play()
	


func ouch(damage_amount):
	play_sound()
	print("hey")
	health -= damage_amount
	
	
	if health <= 0:
		hide()
		Score.set_score(Score.score + 1)
		$CollisionShape2D.set_deferred("disabled", true)
		
		
		
		
		
	
