extends Node


@export var projectile_image = "astronaut"
@export var stats: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectile_image = "astronaut"
	stats = {}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_stat(modifier):
	#$AnimatedSprite2D.scale = Vector2(.2, .2)
	for key in modifier:
		stats[key] = modifier[key]
