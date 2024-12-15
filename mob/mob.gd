extends RigidBody2D

signal score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	hide()
	queue_free()
	
func game_over():
	hide()
	queue_free()


func ouch():
	hide()
	Score.set_score(Score.score + 1)
	$CollisionShape2D.set_deferred("disabled", true)


func _on_body_entered(body: Node) -> void:
	ouch()
